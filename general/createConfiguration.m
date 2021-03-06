%% CreateConfiguration - Creates a basic configuration for the 
%            MatCardiacMLab Simulator
%                                
%
%    config = createConfiguration(Model,Constants,Values,DT,Stimulation,
%                              Time,sv_save,cv_save,optional) 
%                                                                                                                                               
%    Input:                                                                 
%      Model:       MatCardiacMLab Model Structure or string with the 
%                   name of the model in the database that will be used
%      Constants:   Cell array with the name of the model constants that
%                   will be modified in the simulation
%      Values:      Vector with the new values for the constants.
%      DT:          Step size for the output in milliseconds
%      Stimulation: Vector with the instants of stimulations in ms. The
%                   first element indicates the time init (value 0 is 
%                   recommended).
%      TimeEnd:     Instant of time where the simulation ends (ms).   
%      sv_save:     Cell array with the names of the State Variables to 
%                   save.
%      cv_save:     Cell array with the names of the Computed Variables
%                   to save.
%      optional:    Pairs of parameteres to indiate other options
%          ResultFile:  Name of the file where the results are stored.
%          ConfigFile:  Name of the file where the configuration has to
%                       be saved (Optional).
%        
%   It's possible to define a sequence of simulations with different 
%   parameters. To do this, put the vectors of Constants, Values, 
%   Stimulation, sv_save and cv_save in a cell array. Each position of
%   the array indicates one simulation.
%
%       Example:
%         Model = 'Carro2011EPI';
%         Constants = {{},{'A_NaK'}};
%         Values = {[],[0.9]};
%         DT = 0.1;
%         Stimulation = {[0:1000:9000],[10000:1000:19000]};
%         TimeEnd = 20000; % Global simulation end.
%         sv_save = {{'V'},{'V'}};
%         cv_save = {{},{'I_NaK'}};
%         ResultFile = 'OutputFile.mat';
%         
%         config = createConfiguration(Model,Constants,Values,DT,
%                        Stimulation,Time,sv_save,cv_save,'ResultFile',
%                        ResultFile)
%                                                                  
%    Output:  
%      config: Structure with the configuration of the simulation.
%
%    Throws:
%      InconsistentConstants: Length of the Constants cell array is 
%                   different from the length of Values
%      InconsistentOptional: The optional configuration is composed by
%                   and odd number of parameters.
%      NoDefinedOption: The option is not defined
%
%-----------------------------------------------------------------------
% 
% MatCardiacMLab
%
% Matlab toolbox to Simulate Electrophysiologycal Cardiac Models 
% described in CellML files
%
% https://github.com/ChusCarro/MatCardiacMLab/
%
%
% Jesus Carro Fernandez 
% jcarro@usj.es  
%                      
% School of Engineering
% San Jorge University 
% www.usj.es  
%

function config = createConfiguration(Model,Constants,Values,DT,...
    Stimulation,TimeEnd,sv_save,cv_save,varargin)

if(length(Constants)~=length(Values))
  error('MatCardiacMLab:createConfiguration:InconsistentConstants',...
     ['Length of the Constants cell array is different from the ' ...
     'length of Values'])
end

config.Model = Model;
config.Constants = Constants;
config.Values = Values;
config.DT = DT;
config.Stimulation = Stimulation;
config.TimeEnd = TimeEnd;
config.sv_save = sv_save;
config.cv_save = cv_save;

ConfigFile = [];

if (mod(length(varargin),2)>0)
  error('MatCardiacMLab:createConfiguration:InconsistentOptional',...
     ['Optional parameters must be in pairs'])
end

length(varargin)

for i=1:(length(varargin)/2)
  if(strcmp(varargin{2*i-1},'ResultFile'))
    config.ResultFile = varargin{2*i};
  else if(strcmp(varargin{2*i-1},'ConfigFile'))
      ConfigFile = varargin{2*i};
    else
      error('MatCardiacMLab:createConfiguration:NoDefinedOption',...
         ['Option ' varargin{2*i-1} ' is not defined'])
    end
  end

end

if(~isempty(ConfigFile))
  save(ConfigFile,'-struct','config');
end
 
