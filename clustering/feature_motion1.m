clear
clc
close all

load person_t.mat
addpath export_fig/
nframes=1000;

[x1 x2]=size(person_tracks);
index=1;

feature_motion=[];
interval=26;
while(index<nframes-interval)
      motion_mat=[];
pt=[];
        for k=1:x2
           x=person_tracks{k};
           xx=x(index:index+interval-1);
           if(all(xx == 0))
               k;
           else
            pt=[pt;xx];
           all(xx==0);
              
           end
        end
       [p1 p2]= size(pt);
       
xx;
for i=1:p1
    
    size(pt(i,:));
    tr=pt(i,:);
    [t1 t2]=size(tr);
    
    for j=1:t2
      if(tr(j)~=0)
          s1=j;break;
      end
    end
    s2=interval;
        for j=s1:t2
      if(tr(j)==0)
          s2=j-1;break;
      end
       end

  
  for j=s1:s2-1   
      dpmfname = sprintf('../person_detection/voc-release5/10/%d.mat',index-1+j);
      load(dpmfname);
size(bbox)      ;
x11=bbox(tr(j),1);
x12=bbox(tr(j),3);
y11=bbox(tr(j),2);
y12=bbox(tr(j),4);
centerx=(x11+x12)/2;
centery=(y11+y12)/2;
      j;
      
            dpmfname = sprintf('../person_detection/voc-release5/10/%d.mat',index-1+j+1);
      load(dpmfname);
size(bbox)   ;   
x11=bbox(tr(j+1),1);
x12=bbox(tr(j+1),3);
y11=bbox(tr(j+1),2);
y12=bbox(tr(j+1),4);
centerx1=(x11+x12)/2;
centery1=(y11+y12)/2;

mot=sqrt((centerx-centerx1)^2+(centery-centery1)^2);
      feature_motion=[feature_motion mot];
  end
      
      
  
        
       end
    
    

    

        %Find all bounding boxes which are part of tracks



index=index+interval/2

end
pt;

%Learn Histogram centers
[cnt,center]=hist(feature_motion,64);

%LEarn motion feature

motion1=[];
index=1;

while(index<nframes-interval)
      motion_mat=[];
pt=[];
        for k=1:x2
           x=person_tracks{k};
           xx=x(index:index+interval-1);
           if(all(xx == 0))
               k;
           else
            pt=[pt;xx];
           all(xx==0);
              
           end
        end
       [p1 p2]= size(pt);
       
xx;
for i=1:p1
    
    size(pt(i,:));
    tr=pt(i,:);
    [t1 t2]=size(tr);
    
    for j=1:t2
      if(tr(j)~=0)
          s1=j;break;
      end
    end
    s2=interval;
        for j=s1:t2
      if(tr(j)==0)
          s2=j-1;break;
      end
       end

  
  for j=s1:s2-1   
      dpmfname = sprintf('../person_detection/voc-release5/10/%d.mat',index-1+j);
      load(dpmfname);
size(bbox)      ;
x11=bbox(tr(j),1);
x12=bbox(tr(j),3);
y11=bbox(tr(j),2);
y12=bbox(tr(j),4);
centerx=(x11+x12)/2;
centery=(y11+y12)/2;
      j;
      
            dpmfname = sprintf('../person_detection/voc-release5/10/%d.mat',index-1+j+1);
      load(dpmfname);
size(bbox)   ;   
x11=bbox(tr(j+1),1);
x12=bbox(tr(j+1),3);
y11=bbox(tr(j+1),2);
y12=bbox(tr(j+1),4);
centerx1=(x11+x12)/2;
centery1=(y11+y12)/2;

mot=sqrt((centerx-centerx1)^2+(centery-centery1)^2);
      motion_mat=[motion_mat mot];
  end
      
      
  
        
end
       mm=hist(motion_mat,center);
       
       
      motion1=[motion1; index index+interval-1 mm];
 
    
    

    

        %Find all bounding boxes which are part of tracks



index=index+interval/2

end
feature_motion=motion1;
save feature_motion.mat feature_motion








