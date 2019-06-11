function [] = writeRxnChanges(rxnChanges,fileName,date)
%writeRxnChanges  Write model reaction change structure to file.
%
% USAGE:
%
%   writeRxnChanges(rxnChanges, fileName, date);
%
% INPUT:
%
%   rxnChanges     A structure generated by "docRxnChanges" that contains
%                  information on changed model reactions. Should contain
%                  the following fields:
%                       rxn   cell array of reaction IDs
%                   eqnOrig   cell array of original reaction equations
%                    eqnNew   cell array of new reaction equations
%                    lbOrig   vector of original lower bounds
%                     lbNew   vector of new lower bounds
%                    ubOrig   vector of original upper bounds
%                     ubNew   vector of new upper bounds
%                grRuleOrig   cell array of original reaction grRules
%                 grRuleNew   cell array of new reaction grRules
%                     notes   cell array of notes associated with the changes
%
%   fileName       Name of file to write to. If an extension is not
%                  provided, ".tsv" will be used.
%
%   date           (Opt, default TRUE) print out the date in the first
%                  line of output file, or not if FALSE.
%
%
% Jonathan Robinson, 2019-05-17
%

% handle input arguments
if nargin < 3
    date = true;
end
if ~contains(fileName,'.')
    % append with .tsv if no extension provided
    fileName = strcat(fileName,'.tsv');
end

% organize information into an array format
chgArray = [fieldnames(rxnChanges)';
            [rxnChanges.rxns, rxnChanges.eqnOrig, rxnChanges.eqnNew,...
            num2cell([rxnChanges.lbOrig, rxnChanges.lbNew, ...
            rxnChanges.ubOrig, rxnChanges.ubNew]), rxnChanges.grRuleOrig, ...
            rxnChanges.grRuleNew, rxnChanges.notes]];

% write to file
writecell(chgArray,fileName,true,'\t','%s\t%s\t%s\t%f\t%f\t%f\t%f\t%s\t%s\t%s\n',date);


