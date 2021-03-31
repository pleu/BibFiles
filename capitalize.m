function Supper=capitalizeNew(S,skipset)
%function S=capitalize(S) 
% Capitalize the first character in every word (excluding short words) in input
% string S, or in every word in every string in input cell array S.  The first word
% is always capitalized.
%
% Default set of words to skip is {'a','an','and','or','in','the'}
%
% function S=capitalize(S,skipset)
% User-supplied cell array of words to skip 

if nargin<2 
    skipset={'a','an','and','or','in','the'}; 
end
skipset=lower(skipset);

if iscell(S)
    S=cellfun(@(x) capitalize(x, skipset),S,'uniformoutput',false);
else
    skipSet=0;
    %bracketSet = 0;
    Sw=regexp(S,'[ \t]','split');
    
    %idx = regexp([' ' S], '[ \t-]','start');
    %idxBracket = regexp([' ' S], '{','start');
    %idx = regexp([' ' S], '(?<=\s+)\S','start')-1
    %keep(2:length(Sw))=ismember(Sw(1),'{'); %skip(1) is always 0
    
    % only want to lower everything that is not in parentheses
    % first determine which words are not in parentheses
    
    %Slower = lower(S;
    %Slower = sprintf('%s', lower(S(~keep)));
    %Slower(~idxBracket) = lower(S(~keep));
    %Supper = Slower;
    %S=sprintf('%s ',Slower{:});
    %Slower(end)='';
    %bracketSet = Sw(2:end);
    
    bracketSet = cellfun(@(x) strcmp(x(1), {'{'}),Sw,'uniformoutput',false);
    bracketSet = vertcat(bracketSet{:})';
    
%     bracketSetEnd = cellfun(@(x) strcmp(x(end), {'}'}),Sw,'uniformoutput',false);
%     bracketSetEnd = vertcat(bracketSetEnd{:})';

    %bracketSet = cellfun(@(x) strcmp(x(1), {'{'}) & strcmp(x(end), {'}'}),Sw,'uniformoutput',false);
    %Sw(~skip)=cellfun(@(x) [upper(x(1)) x(2:end)],Sw(~skip),'uniformoutput',false);
    
    %skipSet(2:length(Sw))=ismember(lower(Sw(2:end)),skipset); %skip(1) is always 0
    skipSet(2:length(Sw))=ismember(lower(Sw(2:end)),skipset); %skip(1) is always 0
    skip = skipSet | bracketSet; % | bracketSetEnd;
    %skip = skip | keep;
    
    % split with hyphens
    %Shyphen=regexp(Sw(~skip),'-','split');
    %Sw = cellfun(@(x) strcmp(x(1), {'{'}),Sw,'uniformoutput',false);
    skipSet
    Sw(logical(skipSet))=cellfun(@(x) lower(x),Sw(logical(skipSet)),'uniformoutput',false);
    %Sw(~skip)=cellfun(@(x) [upper(x(1)) lower(x(2:end))],Shyphen(~skip),'uniformoutput',false);
    Sw(~skip)=cellfun(@(x) [upper(x(1)) lower(x(2:end))],Sw(~skip),'uniformoutput',false);
    Supper=sprintf('%s ',Sw{:});
    Supper(end)='';
    
    
    idx = regexp([' ' Supper], '-','start');
    Supper(idx) = upper(Supper(idx));
    %Sw=regexp(Supper,'-','split');
    %idx = regexp([' ' S], '-','start');
    %Supper = Sw;
    %Supper(idx(~skip)) = upper(S(idx(~skip)));
    %Supper(idx(~skip)) = upper(S(idx(~skip)));
end

