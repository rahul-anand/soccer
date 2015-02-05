function []=visualize_track(trackno)
load person_t.mat
addpath export_fig/
x=person_tracks{trackno}
[x1 x2]=size(x);
offset=30600;
imgpath='../sc/10/';


tic
outputVideo = VideoWriter('shuttle_out.avi');
outputVideo.FrameRate = 30;
open(outputVideo);
;



for i=1:x2
           dpmfname = sprintf('../person_detection/voc-release5/10/%d.mat',i);
             load(dpmfname);
       [nboxes len]=size(bbox);

       img_no=30600+i;
                img_name = sprintf('../sc/10/%d.jpg',img_no);
  
   if(x(1,i)~=0)
      
       box_track=bbox(x(i),:);
       j=x(i);
       x1=bbox(j,1);
          x2=bbox(j,3);
          y1=bbox(j,2);
          y2=bbox(j,4);
       bb=bbox(x(i),:);
 
   im=imread(img_name);
   %image(im);
              ff = sprintf('frames/%d.jpg',i)

    showboxes(im, bb,ff);  
    close all;
     writeVideo(outputVideo,im)
  end
    
end
close(outputVideo);
close all;
end