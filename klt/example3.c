/**********************************************************************
 * Finds the 150 best features in an image and tracks them through the 
 * next two images.  The sequential mode is set in order to speed
 * processing.  The features are stored in a feature table, which is then
 * saved to a text file; each feature list is also written to a PPM file.
 * **********************************************************************/

#include <stdlib.h>
#include <stdio.h>
#include "pnmio.h"
#include "klt.h"

#define REPLACE

int nFrames=20000;
int main(int argc,char*argv[])

{
  unsigned char *img1, *img2;
  char fnamein[100], fnameout[100];
  KLT_TrackingContext tc;
  KLT_FeatureList fl;
  KLT_FeatureTable ft;
  int nFeatures = 10000;
  int ncols, nrows;
  int i;
printf("%s\n",argv[1]);
printf("%s\n",argv[2]);
printf("%d\n",nFrames);
  tc = KLTCreateTrackingContext();
  fl = KLTCreateFeatureList(nFeatures);
  ft = KLTCreateFeatureTable(nFrames, nFeatures);
  tc->sequentialMode = TRUE;
  tc->writeInternalImages = FALSE;
  tc->affineConsistencyCheck = 2 ;  /* set this to 2 to turn on affine consistency check */
  tc->mindist = 4 ;
printf("%d\n",nFrames);
     sprintf(fnamein, "%s/%d.pgm",argv[1],0);
  img1 = pgmReadFile(fnamein, NULL, &ncols, &nrows);
  img2 = (unsigned char *) malloc(ncols*nrows*sizeof(unsigned char));

  KLTSelectGoodFeatures(tc, img1, ncols, nrows, fl);
  KLTStoreFeatureList(fl, ft, 0);
  KLTWriteFeatureListToPPM(fl, img1, ncols, nrows, "feat0.ppm");
  for (i =  1; i < nFrames ; i++)  {
    sprintf(fnamein, "%s/%d.pgm", argv[1],i);
    pgmReadFile(fnamein, img2, &ncols, &nrows);
    KLTTrackFeatures(tc, img1, img2, ncols, nrows, fl);
#ifdef REPLACE
    KLTReplaceLostFeatures(tc, img2, ncols, nrows, fl);
#endif
    KLTStoreFeatureList(fl, ft, i);
    sprintf(fnameout, "%s/feat%d.ppm", argv[2],i);
    KLTWriteFeatureListToPPM(fl, img2, ncols, nrows, fnameout);
  }
    sprintf(fnameout, "%s/features.txt", argv[2]);
  KLTWriteFeatureTable(ft, fnameout, "%5.1f");
    sprintf(fnameout, "%s/features.ft", argv[2]);
  KLTWriteFeatureTable(ft, fnameout, NULL);

  KLTFreeFeatureTable(ft);
  KLTFreeFeatureList(fl);
  KLTFreeTrackingContext(tc);
  free(img1);
  free(img2);

  return 0;
}

