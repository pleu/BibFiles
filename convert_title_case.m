clear;
filename = 'LAMPPapers.bib';
skipSet = {'the', 'and', 'nor', 'or', 'yet', 'so', 'a', 'amid', 'an', 'apud', 'as', 'at', 'atop', 'but', 'by', 'down', 'for', 'from', 'in', 'into', 'like', 'mid', 'near', 'next', 'of', 'off', 'on', 'onto', 'out', 'over', 'pace', 'past', 'per', 'plus', 'pro', 'qua', 'sans', 'save', 'than', 'till', 'to', 'unto', 'up', 'upon', 'via', 'vice', 'vs.', 'with'};
% fid = fopen(filename, 'r');
% %data = readmatrix(filename,'OutputType','string','Delimiter','=','Whitespace','','FileType', 'text')
% %data = textscan(fid, string, 'delimiter',',', 'Headerlines', 1);
% data = textscan(fid,'%s %s %s %s %s','delimiter',{'='});
% %data = textscan(fid,'%s %s','delimiter',{'\n'});
% fclose(fid);

fid = fopen(filename);
tline = fgetl(fid);

filenameParse = strsplit(filename, '.');
fidOut = fopen([filenameParse{1}, 'New.bib'], 'w');

while ischar(tline)
    %disp(tline)
    splitcells = regexp(tline,'=','split','once');
    if strcmpi(strtrim(splitcells{1}), 'Title')
      titleBrackets = strtrim(splitcells{2});
      title = titleBrackets(2:length(titleBrackets)-2);
      endString = titleBrackets(length(titleBrackets)-1:end);
      titleCase = capitalize(title, skipSet);
      output = [' {', titleCase, endString];
      splitcells{2} = output;
    end
%     if data{1}{i}(1) == '@'
%       fprintf(fid, '\n');
%     end
    if length(splitcells) == 1
      %outputString = [splitcells{1}]; %, ' = ', splitcells{2}];
      fprintf(fidOut, '%s \n', splitcells{1});
      %fprintf(fidOut, [splitcells{1}, '\n']);
    else
      outputString = [splitcells{1}, ' = ', splitcells{2}];
      fprintf(fidOut, '%s \n', outputString);
    end
    tline = fgetl(fid);
end

% data2 = textscan(fid,'%s %s','delimiter',{'=', '\n'});
% fclose(fid);

% 
% for i = 1:length(data{1})
%   if strcmp(strtrim(data{1}{i}), 'Title')
%     titleBrackets = strtrim(data{2}{i});
%     title = titleBrackets(2:length(titleBrackets)-2);
%     titleCase = capitalize(title, skipSet);
%     data{2}{i} = [' {', titleCase, '},'];
%   end
% end
% 
% for i = 1:length(data{1})
%   if data{1}{i}(1) == '@'
%     fprintf(fid, '\n');
%   end
%   if isempty(data{2}{i})
%     fprintf(fid, [data{1}{i}, '\n']);
%   else
%     fprintf(fid, [data{1}{i}, ' = ', data{2}{i}, '\n']);
%   end
% end
% fclose(fid);

