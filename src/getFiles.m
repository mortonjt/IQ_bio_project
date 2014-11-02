function files = getFiles(dirname,var_well,wavelength,timepoint)
  %example: /data2/IQBIO2014/Inhibitor Timecourses/0hr
  f = dir(dirname);
  dir_pattern = sprintf('well %s(1[0-9]|0[2-9])+',var_well);
  file_pattern = sprintf('.*wavelength %d.*%d.tif',wavelength,timepoint);
  directories = regexpi({f.name},dir_pattern,'match');
  directories = [directories{:}];
  files = cell(4,length(directories));
  for i=1:length(directories)
     welldir = dir(sprintf('%s/%s',dirname,directories{i}));
     wells = regexpi({welldir.name},file_pattern,'match');
     wells = [wells{:}];
     
     files{1,i} = sprintf('%s/%s/%s',dirname,directories{i},wells{1});
     files{2,i} = sprintf('%s/%s/%s',dirname,directories{i},wells{2});
     files{3,i} = sprintf('%s/%s/%s',dirname,directories{i},wells{3});
     files{4,i} = sprintf('%s/%s/%s',dirname,directories{i},wells{4});
  end

end
