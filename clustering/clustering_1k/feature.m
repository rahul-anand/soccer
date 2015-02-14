clear all
clc
close all

load person_t.mat
addpath export_fig/
nframes=1000;

[x1 x2]=size(person_tracks);
index=1;
area_finalmat=[];
interval=26;
while(index<nframes-interval)
       area_mat=[];
    for i=index:index+interval


        %Find all bounding boxes which are part of tracks
    y=[];

    for k=1:x2
    x=person_tracks{k};
    
    
    y=[y; nonzeros(x(i))];
    end
    %remove duplicate boxes
    y=unique(y);
    [y1 y2]=size(y);
     dpmfname = sprintf('../person_detection/voc-release5/10/%d.mat',i);
     dpmfname;
             load(dpmfname);
       [nboxes len]=size(bbox);
    %for each bounding box in each frames
    for k=1:y1
        j=y(k);
        x11=bbox(j,1);
          x12=bbox(j,3);
          y11=bbox(j,2);
          y12=bbox(j,4);
        
      area=abs(x11-x12)*abs(y11-y12);  
      area_mat=[area_mat;area];
    end
 %  break; 
    end
        
 index;
if(isnan(mean(area_mat)))
   i
   y
   index
   break;
else
    index
    
          area_finalmat=[area_finalmat;index index+interval mean(area_mat)]
  
end
index=index+interval/2;    

end
save area_final.mat area_finalmat



