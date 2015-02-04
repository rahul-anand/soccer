i1
k=i1+6000
i1,k
startup
addpath export_fig/

models={'VOC2007/person_final.mat';'VOC2007/person_grammar_final.mat';'VOC2010/person_final.mat';'VOC2010/person_grammar_final.mat';'INRIA/inriaperson_final.mat'};
[j1 j2]=size(models)
thr=-1;
pathstr1='../../sc/10/';
pathstr2='10/';
models{3}
load(models{3})
%for i=30600:206160

st=i1;
e1=k;
count=st-30600;
i1,k
st,e1
for i=st:e1
tic
    j1=strcat(pathstr1,num2str(i));
        j1=strcat(j1,'.jpg');



ff=strcat(pathstr2,num2str(count));
ff=strcat(ff,'.mat')
if exist(ff ,'file')
 S=sprintf('Exists %s',ff);
 disp(S)
 count=count+1

 continue;
toc
end
im = imread(j1); 
im = imresize(im, 2,'bilinear');
bbox = process(im, model,thr); 
%showboxes(im, bbox,ff);  
save(ff,'bbox');

     count=count+1

toc

end

