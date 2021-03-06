function [trialCondition,trialIndex] = calculateConditions()
% calculate all movement conditions for different movement types.
% the result show in a cell of metrixs:
% moving type 1: fixation:
% [moveDuration, headingDegree, headingSpeed]
%
% moving type 2: normal pursuit
% [moveDuration, headingDegree, headingSpeed, fixMoveDirection, fixSpeed]
%
% moving type 3: simulated pursuit
% [moveDuration, headingDegree, headingSpeed, rotationDegree, rotationSpeed]
%
% moving type 4: stabilized pursuit
% [moveDuration, headingDegree, headingSpeed, fixMoveDirection, fixSpeed]
%
% trialCondition = [{moving type 1},{moving type 2},{moving type 3},{moving type 4}]
% 
% trialIndex: [motion types , condition number in each moving type]
% 
% March 2019 by BYC
global TRIALINFO

% moving type 1
% [moveDuration, headingDegree, headingSpeed, condition marker]
moveCondition1 = [];
if sum(ismember(TRIALINFO.motionType,1))
    % merge heading degree and heading speed in a metrix of [heading degree, heading speed]
    mov1HdHs = [sort(repmat(TRIALINFO.headingDegree',length(TRIALINFO.headingSpeed),1)),...
        repmat(TRIALINFO.headingSpeed',length(TRIALINFO.headingDegree),1)];
    
    % merge moving duration in the previous metrix as [moving duration, heading degree, heading speed]
    mov1MdHdHs = [sort(repmat(TRIALINFO.moveDuration',length(TRIALINFO.headingSpeed)*length(TRIALINFO.headingDegree),1),1),...
        repmat(mov1HdHs,length(TRIALINFO.moveDuration),1)];
    moveCondition1 = [mov1MdHdHs, ones(size(mov1MdHdHs,1),1)*1];
end
trialIndex1 = [ones(size(moveCondition1,1),1)*1, (1:size(moveCondition1,1))'];

% moving type 2
% [moveDuration, headingDegree, headingSpeed, fixMoveDirection, fixSpeed, condition marker]
moveCondition2 = [];
if sum(ismember(TRIALINFO.motionType,2))
    mov2FdFs = [sort(repmat(TRIALINFO.fixMoveDirection',length(TRIALINFO.fixSpeed),1)),...
        repmat(TRIALINFO.fixSpeed',length(TRIALINFO.fixMoveDirection),1)];
    
    mov2HsFdFs = [sort(repmat(TRIALINFO.headingSpeed',length(TRIALINFO.fixSpeed)*length(TRIALINFO.fixMoveDirection),1),1),...
        repmat(mov2FdFs,length(TRIALINFO.headingSpeed),1)];
    
    mov2HdHsFdFs = [sort(repmat(TRIALINFO.headingDegree',length(TRIALINFO.fixSpeed)*length(TRIALINFO.fixMoveDirection)*length(TRIALINFO.headingSpeed),1),1),...
        repmat(mov2HsFdFs,length(TRIALINFO.headingDegree),1)];
    
    mov2MdHdHsFdFs = [sort(repmat(TRIALINFO.moveDuration',length(TRIALINFO.headingDegree)*length(TRIALINFO.fixSpeed)*length(TRIALINFO.fixMoveDirection)*length(TRIALINFO.headingSpeed),1),1),...
        repmat(mov2HdHsFdFs,length(TRIALINFO.moveDuration),1)];
    
    moveCondition2 = [mov2MdHdHsFdFs, ones(size(mov2MdHdHsFdFs,1),1)*2];
end
trialIndex2 = [ones(size(moveCondition2,1),1)*2, (1:size(moveCondition2,1))'];

% moving type 3
% [moveDuration, headingDegree, headingSpeed, rotationDegree, rotationSpeed, condition marker]
moveCondition3 = [];
if sum(ismember(TRIALINFO.motionType,3))
   mov3RdRs  = [sort(repmat(TRIALINFO.rotationDegree',length(TRIALINFO.rotationSpeed),1)),...
       repmat(TRIALINFO.rotationSpeed',length(TRIALINFO.rotationDegree),1)];
   
   mov3HsRdRs = [sort(repmat(TRIALINFO.headingSpeed',length(TRIALINFO.rotationSpeed)*length(TRIALINFO.rotationDegree),1),1),...
       repmat(mov3RdRs,length(TRIALINFO.headingSpeed'),1)];
   
   mov3HdHsRdRs = [sort(repmat(TRIALINFO.headingDegree',length(TRIALINFO.headingSpeed)*length(TRIALINFO.rotationSpeed)*length(TRIALINFO.rotationDegree),1),1),...
       repmat(mov3HsRdRs,length(TRIALINFO.headingDegree),1)];
   
   mov3MdHdHsRdRs = [sort(repmat(TRIALINFO.moveDuration',length(TRIALINFO.headingDegree)*length(TRIALINFO.headingSpeed)*length(TRIALINFO.rotationSpeed)*length(TRIALINFO.rotationDegree),1),1),...
       repmat(mov3HdHsRdRs,length(TRIALINFO.moveDuration),1)];
   
   moveCondition3 = [mov3MdHdHsRdRs, ones(size(mov3MdHdHsRdRs,1),1)*3];
end
trialIndex3 = [ones(size(moveCondition3,1),1)*3, (1:size(moveCondition3,1))'];

% moving type 4
% [moveDuration, headingDegree, headingSpeed, fixMoveDirection, fixSpeed, condition marker]
moveCondition4 = [];
if sum(ismember(TRIALINFO.motionType,4))
   mov4FdFs = [sort(repmat(TRIALINFO.fixMoveDirection',length(TRIALINFO.fixSpeed),1)),...
       repmat(TRIALINFO.fixSpeed',length(TRIALINFO.fixMoveDirection),1)];
   
   mov4HsFdFs = [sort(repmat(TRIALINFO.headingSpeed',length(TRIALINFO.fixMoveDirection)*length(TRIALINFO.fixSpeed),1),1),...
       repmat(mov4FdFs,length(TRIALINFO.headingSpeed),1)];
   
   mov4HdHsFdFs = [sort(repmat(TRIALINFO.headingDegree',length(TRIALINFO.headingSpeed)*length(TRIALINFO.fixMoveDirection)*length(TRIALINFO.fixSpeed),1),1),...
       repmat(mov4HsFdFs,length(TRIALINFO.headingDegree),1)];
   
   mov4MdHdHsFdFs = [sort(repmat(TRIALINFO.moveDuration',length(TRIALINFO.headingDegree)*length(TRIALINFO.headingSpeed)*length(TRIALINFO.fixMoveDirection)*length(TRIALINFO.fixSpeed),1),1),...
       repmat(mov4HdHsFdFs,length(TRIALINFO.moveDuration),1)];
   
   moveCondition4 = [mov4MdHdHsFdFs, ones(size(mov4MdHdHsFdFs,1),1)*4];
end
trialIndex4 = [ones(size(moveCondition4,1),1)*4, (1:size(moveCondition4,1))'];

trialCondition = [{moveCondition1},{moveCondition2},{moveCondition3},{moveCondition4}];
trialIndex = [trialIndex1; trialIndex2; trialIndex3; trialIndex4];