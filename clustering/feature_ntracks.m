clear
clc
close all

load person_t.mat
addpath export_fig/
nframes=1000;

[x1 x2]=size(person_tracks);
index=1;

ntracks=[];
interval=26;
while(index<nframes-interval)
   
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
       
p1

    
    
ntracks=[ntracks; index index+interval-1 p1];
    

       



index=index+interval/2

end
pt;

save feature_ntracks.mat ntracks








