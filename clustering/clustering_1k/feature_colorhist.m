
clear
clc
close all

load person_t.mat
addpath export_fig/
nframes=1000;

[x1 x2]=size(person_tracks);
index=1;

feature_hist=[];
interval=26;
while(index<nframes-interval)
      hist_mat=[];
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

  
  for j=s1:s2   
      dpmfname = sprintf('../person_detection/voc-release5/10/%d.mat',index-1+j);
      load(dpmfname);
size(bbox)      ;
x11=round(bbox(tr(j),1));
x12=round(bbox(tr(j),3));
y11=round(bbox(tr(j),2));
y12=round(bbox(tr(j),4));

     
                img_name = sprintf('../sc/10/%d.jpg',30600+index-1+j);
                pp=imread(img_name);
                pp=imresize(pp,2,'bilinear');
                [l1 l2 col]=size(pp);
                if(x12>l1)
                    x12=l1;
                end
                if(y12>l2)
                    y12=l2;
                end
                pop=pp(x11:x12,y11:y12,:);
                x11;
                x12;
                y11;
                y12;
                h=rgbhist(pop,4,2);
                hist_mat=[hist_mat;h'];
               size(hist_mat)    ;

                size(pop);
                
                
  end
      
      
  
        
       end
    
size(hist_mat)   
feature_hist=[feature_hist;index index+interval-1 mean(hist_mat)];

        %Find all bounding boxes which are part of tracks



index=index+interval/2

end
pt;


