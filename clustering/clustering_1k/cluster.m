clear all
clc
close all

tic

[x,y,val]=klt_read_featuretable('features.txt');

[nfeatures nframes]=size(x)
nframes=1100
%Store KLT Features belonging to each bounding box
disp('Storing KLT Features for each Bounding Box');
tic
for i=1:nframes
      
       dpmfname = sprintf('../person_detection/voc-release5/10/%d.mat',i);
       load(dpmfname);
       [nboxes len]=size(bbox);
       nbox(i)=nboxes;
       for j=1:nboxes
          x1=bbox(j,1);
          x2=bbox(j,3);
          y1=bbox(j,2);
          y2=bbox(j,4);
          kltx=x(:,i);
          klty=y(:,i);
          corrx=find(kltx>=x1 & kltx<=x2);
          corry=find(klty>=y1 & klty<=y2);
            kltracks = intersect(corrx,corry);
           
           feat{i,j}=kltracks;
       end       
       
end

toc
tic
%Compare  all possible bounding boxes in consecutive frames 
% Store as pair if more than 50% of KLT Features match
disp('Computing Pairwise Bounding Boxes with more than 50% Match');


for i=1:nframes-1
    nboxf1=nbox(i);
    nboxf2=nbox(i+1);
    
    for j=1:nboxf1
        for k=1:nboxf2
            
    bboxf1=feat{i,j};
    bboxf2=feat{i+1,k};
    s1=size(bboxf1);
    s2=size(bboxf2);
    inter=intersect(bboxf1,bboxf2);
    comp=100*size(inter)/max(s1,s2);
    if(comp>=50.0 & ~isempty(inter) )
      
       pair{i,j}=k;

    end
            
        end
    end           
 
end


toc
%Compute Person track given pair(computed above)
tic
disp('Computing Person Tracks');


count=1;
for i=1:nframes-1
    
    for j=1:nbox(i)
        
        [ll pp]=size(pair);
        if(i>ll || j>pp)
            continue;
        end
        
        if (~isempty(pair{i,j}))
            pt=[i j];
            
            st1=i;st2=j;
            [ss1 ss2]=size(pair);
            
            
            while(~isempty(pair{st1,st2}))
               newst2=pair{st1,st2};
               newa=[st1+1 newst2];
               pt=[pt newa];
               st2=newst2;
               st1=st1+1;
                
               if(st1>ss1 || st2 >ss2)
                   break;
               end
        st1,st2,size(pair);
                
            end
            pt
            ptrack{count}=pt;
            count=count+1
          
            
           i,j,pair{i,j} ;
        end        
    end    
    
    
end


toc
tic
%Storing Efficinetly 

newcount=0;
for i=1:count-1
    i
    A=ptrack{i};
    
    [tt s1]=size(A)
    
    ptr=zeros(1,nframes);
    j=1;
    while(j<=s1)
       ptr(A(1,j))=A(1,j+1);
       j=j+2;
       s1;
       
        
    end
       newptrack{i}=ptr; 
        
           
end

toc
tic
disp('Removing Sub/Duplicate Tracks');

%Removing Sub Tracks of a Track


cnt=1;

    for i=1:count-1
        repeat=0;
           A=newptrack{i};

        for j=1:count-1
        
   B=newptrack{j};
   [a1 a2]=size(A);
   [b1 b2]=size(B);
   s1=1;
  
   for k=1:a2
      if(A(k)~=0)
          s1=k;break;
      end
   end
   s2=a2;
   for k=s1:a2
      if(A(k)==0)
          s2=k-1;break;
      end
       
   end
   
   s3=1;
  
   for k=1:b2
      if(B(k)~=0)
          s3=k;
          break;
      end
   end
   s4=b2;
   for k=s3:b2
      if(B(k)==0)
          s4=k-1;
          break;
      end
       
   end
   
 
     
     if(s1>=s3 & s2<=s4)
        
         c1=num2str(A(s1:s2));
         c2=num2str(B(s3:s4));
           
         idx = strfind(c2,c1);
         if(~isempty(idx))
            
         repeat=1;
         break;
             
         end

         
         
         
     end
     
        end

        if(repeat==1 & i~=j)
           A,B,c1,c2,s1,s2,s3,s4,i,j;
        else
            person_tracks{cnt}= A;
           cnt=cnt+1;
        end
    
    
    end
    
    
save person_t.mat person_tracks
toc




