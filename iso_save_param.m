global MAP_DATA
global alg_par
global PAR
global Modul
if isfield(MAP_DATA,'SAVEMAP')
    for i=200:400
        if ishandle(i)
        saveas(i,[MAP_DATA.SAVEMAP.name,'/','data_',sprintf('%d',i),'.png']);
            
        end
    end
    fid=fopen([MAP_DATA.SAVEMAP.name,'/','param.txt'],'wb');
    fwrite(fid,sprintf('iso_experiment : %s \n',MAP_DATA.SAVEMAP.name),'int16');    
    fwrite(fid,sprintf('---iso_par---\n'),'int16');
    fldnms=fieldnames(alg_par);
    for i=1:length(fldnms)
        field=getfield(alg_par,fldnms{i});
        if (isnumeric(field)==1 && numel(field)==1)
            fwrite(fid,sprintf('\t%s = %d \n',fldnms{i},field),'int16');
        end
    end
    
    fwrite(fid,sprintf('---Modul---\n'),'int16');
    fldnms=fieldnames(Modul);
    for i=1:length(fldnms)
        field=getfield(Modul,fldnms{i});
        if (isnumeric(field)==1 && numel(field)==1)
            fwrite(fid,sprintf('\t%s = %d \n',fldnms{i},field),'int16');
        end
    end
    
    fwrite(fid,sprintf('---PAR---\n'),'int16');
    fldnms=fieldnames(PAR);
    for i=1:length(fldnms)
        field=getfield(PAR,fldnms{i});
        if (isnumeric(field)==1 && numel(field)==1)
            fwrite(fid,sprintf('\t%s = %d \n',fldnms{i},field),'int16');
        end
    end    
    fclose(fid);

    global SAVE_results
    if ~isempty(SAVE_results)
        save([MAP_DATA.SAVEMAP.name,'/SAVE_results'],'SAVE_results');
    end

end