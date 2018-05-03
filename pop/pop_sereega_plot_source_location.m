% EEG = pop_sereega_plot_sources(EEG)
%
%       Pops up a dialog to plot the sources associated with the given EEG
%       dataset.
%
%       The pop_ functions serve only to provide a GUI for some of
%       SEREEGA's functions and are not intended to be used in scripts.
%
% In:
%       EEG - an EEGLAB dataset that includes a SEREEGA lead field in
%             EEG.etc.sereega.leadfield and sources in
%             EEG.etc.sereega.sources.
%
% Out:  
%       EEG - the same EEGLAB dataset 
% 
%                    Copyright 2018 Laurens R Krol
%                    Team PhyPA, Biological Psychology and Neuroergonomics,
%                    Berlin Institute of Technology

% 2018-04-30 First version

% This file is part of Simulating Event-Related EEG Activity (SEREEGA).

% SEREEGA is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.

% SEREEGA is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.

% You should have received a copy of the GNU General Public License
% along with SEREEGA.  If not, see <http://www.gnu.org/licenses/>.

function EEG = pop_sereega_plot_source_location(EEG)

% testing if lead field is present
if ~isfield(EEG.etc, 'sereega') || ~isfield(EEG.etc.sereega, 'leadfield') ...
        || isempty(EEG.etc.sereega.leadfield)
    errormsg = 'First add a lead field to the simulation.';
    supergui( 'geomhoriz', { 1 1 1 }, 'uilist', { ...
            { 'style', 'text', 'string', errormsg }, { }, ...
            { 'style', 'pushbutton' , 'string', 'OK', 'callback', 'close(gcbf);'} }, ...
            'title', 'Error');
    return
elseif ~isfield(EEG.etc.sereega, 'components') || isempty(EEG.etc.sereega.components)
    errormsg = 'First add a sources to the simulation.';
    supergui( 'geomhoriz', { 1 1 1 }, 'uilist', { ...
            { 'style', 'text', 'string', errormsg }, { }, ...
            { 'style', 'pushbutton' , 'string', 'OK', 'callback', 'close(gcbf);'} }, ...
            'title', 'Error');
    return
end

% general callback functions
cbf_get_value = @(tag,property) sprintf('get(findobj(''parent'', gcbf, ''tag'', ''%s''), ''%s'')', tag, property);

% callbacks
cb_2d = 'plot_source_location([EEG.etc.sereega.components.source], EEG.etc.sereega.leadfield);';
cb_3d= [ ...
        'shrink = str2num(' cbf_get_value('shrink', 'string') ');' ...
        'view = str2num(' cbf_get_value('view', 'string') ');' ...
        'plot_source_location([EEG.etc.sereega.components.source], EEG.etc.sereega.leadfield, ''mode'', ''3d'', ''shrink'', shrink, ''view'', view);'
        ];

% building gui
inputgui( ...
        'geometry', { 1 1 1 1 1 1 [1 1] 1 [1 1] [1 1] }, ...
        'geomvert', [1 1 1 1 1 1 1 1 1 1], ...
        'uilist', { ...
                { 'style', 'text', 'string', 'Plot source locations', 'fontweight', 'bold' }, ...
                { }, ...
                { 'style', 'text', 'string', 'This plots all sources in the simulation.' }, ...
                { 'style', 'text', 'string', 'To plot individual sources, go to "Select source' }, ...
                { 'style', 'text', 'string', 'locations" under "Configure components".' }, ...
                { }, ...
                { 'style', 'pushbutton', 'string', 'Plot in 2D', 'callback', cb_2d }, ...
                { 'style', 'pushbutton', 'string', 'Plot in 3D', 'callback', cb_3d }, ...
                { }, ...
                { 'style', 'text', 'string', 'Shrink factor' }, ...
                { 'style', 'edit', 'string', '0.5', 'tag', 'shrink' }, ...
                { 'style', 'text', 'string', 'Viewpoint' }, ...
                { 'style', 'edit', 'string', '120, 20', 'tag', 'view' }, ...
                }, ... 
        'helpcom', 'pophelp(''plot_source_location'');', 'title', 'Plot source locations');

end

