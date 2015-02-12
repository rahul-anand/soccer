run vlfeat-0.9.10/toolbox/vl_setup
video_name='10.mp4'
[aa,videostring,cc] = fileparts(video_name);

scratch_dir = ['/scratch/rahul/' videostring];
offset=30600;
if ~exist(scratch_dir)
        system(['mkdir /scratch/rahul/']);
        system(['mkdir ' scratch_dir]);
end

istring = ['/global/ffmpeg/bin/ffmpeg -i ' video_name ' ' scratch_dir '/%d.jpg'];
%system(istring);

nframes=15000
descriptor=[]

%for i=1:500:nframes
%fname = ['/scratch/rahul/' videostring '/' num2str(i+offset) '.jpg']
%i
%im=imread(fname);
%im=imresize(im,2,'bilinear');
%im=single(rgb2gray(im));
 %[drop, descrs] = vl_sift(im);
 %           descriptor=[descriptor single(descrs)];

%end

%save('descriptor.mat','descriptor');

load descriptor.mat
K=300;
[C,A]=vl_kmeans(descriptor,K, 'verbose', 'algorithm', 'elkan');
%load descriptor.mat
 vocab=C;
   model=vl_kdtreebuild(single(vocab));
 numWords = size(vocab,2)
interval=26;
index=1;
bow=[];
cnt=1;
while(index<nframes-interval)
descriptor=[];
cnt=cnt+1
index
size(bow)
 for i=index:index+interval
fname = ['/scratch/rahul/' videostring '/' num2str(i+offset) '.jpg'];

                pp=imread(fname);
                pp=imresize(pp,2,'bilinear');
                                Img = single(rgb2gray(pp));
  [drop, descrs] = vl_sift(Img);
  descriptor=[descriptor single(descrs)];

end

  bins=double(vl_kdtreequery(model,vocab,single(descriptor)));
histss=histnorm(bins,numWords);

if(mod(cnt,10)==0)
save bow.mat bow
end

bow=[bow;index index+interval-1 histss];
index=index+interval/2;

end
