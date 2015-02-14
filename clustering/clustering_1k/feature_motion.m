clear all
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
    for i=index:index+interval-1


        %Find all bounding boxes which are part of tracks
    y=[];

   
  
end
index=index+interval/2;    

end
save feature_final.mat feature_finalmat


