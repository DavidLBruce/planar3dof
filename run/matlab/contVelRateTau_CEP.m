% contVelRateTau_CEP.m
%
% Overview:
%
%  Contour plots of CEP vs target velocity, datalink uplink rate, and
%  missile time constant.
%
% Usage:
%
%  contVelRateTau_CEP( testMatrixFile, statsFile );
%
%  Where the testMatrixFile was created by genTestMatrix.m and the statsFile was
%  created from concatRunSets.sh
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [dat] = contVelRateTau_CEP( testMatrixFile, statsFile )

  mat = loadDataFile( testMatrixFile );

  stats = loadDataFile( statsFile );

  qtyRunSets = mat.runSet( end );

  velVec = unique( mat.tgt.initVxb );
  qtyVel = length( velVec );

  rateVec = unique( mat.gdn.datalinkStep );
  qtyRate = length(rateVec);

  tauVec = unique( mat.ap.tau );
  qtyTau = length( tauVec );

  runSet = 0;
  for ( velIdx = 1 : qtyVel )
    for ( rateIdx = 1 : qtyRate )
      for ( tauIdx = 1 : qtyTau )
        runSet = runSet + 1;
        dat( velIdx ).cep(tauIdx, rateIdx) =  stats.medMiss( runSet );
      end;
    end;
  end;

  labels.x = 'Datalink Interval (sec)';
  labels.y = 'Missile Time Constant (sec)';

  fig = getFig( 'contVelRateTau_CEP 1' );
    figure(fig);
    clf;
    orient landscape;

    mapJet = colormap('jet');
    [mapRows, mapCols] = size(mapJet);

%    mapInvJet = mapJet([mapRows:-1:1],:);

    for (velIdx = 1 : qtyVel)
      
      quadLabel = sprintf( 'Target Velocity = %6.1f m/sec', velVec(velIdx) );

      labels.title = {'CEP Contours', quadLabel};

      plotContour( velIdx, rateVec, tauVec, ...
                              dat(velIdx).cep, mapJet, labels);
    end;

  %  end figure

return;

function plotContour(pos, Xvalues, Yvalues, Zvalues, map, labels)

  subplot(2,2,pos);
  hold on;

  colormap(map);

  [contMat, contGroupH] = contourf( Xvalues, Yvalues, Zvalues, ...
                                   [ 0 : 1/256 : 1], ...
                                   'LineStyle', 'none' );

  [contMat, contGroupH] = contour( Xvalues, Yvalues, Zvalues, ...
                                  [ 0.5 : 0.1 : 1.0 ], 'k' );

  th = clabel(contMat, contGroupH, 'FontSize', 10);
  set(th, 'Color', 'k');

  set(gca, 'CLim', [0.5, 1]);

  xlabel(labels.x);
  ylabel(labels.y);
  title(labels.title);
  
return;
