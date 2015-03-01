classdef CellCaster < mlcaster.CasterStrategy
	%% CELLCASTER casts a variety of interpretable image objects to canonical image types or image references such as
    %  numeric arrays, NIfTI, NiiBrowser, ImagingComponents; cell-array may be heterogeneous
    %
	%  $Revision: 2626 $
 	%  was created $Date: 2013-09-16 01:17:42 -0500 (Mon, 16 Sep 2013) $
 	%  by $Author: jjlee $, 
 	%  last modified $LastChangedDate: 2013-09-16 01:17:42 -0500 (Mon, 16 Sep 2013) $
 	%  and checked into repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mlcaster/src/+mlcaster/trunk/CellCaster.m $, 
 	%  developed on Matlab 8.1.0.604 (R2013a)
 	%  $Id: CellCaster.m 2626 2013-09-16 06:17:42Z jjlee $
 	%  N.B. classdef (Sealed, Hidden, InferiorClasses = {?class1,?class2}, ConstructOnLoad)

    properties (Dependent)
        imagingObject
        defaultPath
        debugging
    end
    
    methods 
        function pth   = get.defaultPath(this)
            pth = this.imagingObject{1}.defaultPath;
        end
        function imobj = get.imagingObject(this)
            assert(~isempty(this.imagingObject_));
            imobj = this.imagingObject_;
        end
        
 		function this = CellCaster(varargin) 
 			%% ImagesCaster 
 			%  Usage:  obj = ImagesCaster() 

            this = this@mlcaster.CasterStrategy(varargin{:});
            assert(~isempty(this.imagingObject));
            if (~iscell(this.imagingObject))
                import mlcaster.*;
                this = CasterStrategy.newStrategy( ...
                       CellCaster.wildcardcast(this.imagingObject, 'fqfileprefix'));
            end
            assert(iscell(this.imagingObject));
        end %  ctor
    end

    methods (Static, Access = 'protected')
        function imobj = cellcast(imobj, newtyp)
            assert(iscell(imobj));
            for f = 1:length(imobj)
                try
                    caster = mlcaster.CasterStrategy.newStrategy(imobj{f});
                    imobj{f} = caster.castto(newtyp);
                catch ME
                    imobj{f} = [];
                    warning('mlcaster:cellAssignmentFailed', ...
                            'CasterStrategy.imcast.ims{%i} -> %s\n\t%s', f, ME.message, struct2str(ME.stack));
                end
            end
        end
        function imobj = cell2ImagingComponent(imobj)
            imobj = mlfourd.ImagingComponent.load(imobj);
        end
        function ims   = wildcardcast(str, newtyp)
            assert(ischar(str));
            assert(lstrfind(str, '*'));
            dt = mlsystem.DirTool(str);
            ims = mlcaster.CellCaster.cellcast(dt.fqfns, newtyp);
        end
    end
    
    methods (Access = 'protected')
        function fps  = cast2fqfileprefix(this)
            dprintf('inside CellCaster.cast2fqfileprefix\n');
            fps = mlcaster.CellCaster.cellcast(this.imagingObject, 'fqfileprefix');
        end
        function ims  = cast2image(this)    
            dprintf('inside CellCaster.cast2image\n');
            ims = mlcaster.CellCaster.cellcast(this.imagingObject, 'mlfourd.NIfTI');
        end
        function fns  = cast2filename(this)
            dprintf('inside CellCaster.cast2filename\n');
            fns = mlcaster.CellCaster.cellcast(this.imagingObject, 'filename');
        end
        function fps  = cast2fileprefix(this)
            dprintf('inside CellCaster.cast2fileprefix\n'); 
            fps = mlcaster.CellCaster.cellcast(this.imagingObject, 'fileprefix');
        end
        function fns  = cast2fqfilename(this)
            dprintf('inside CellCaster.cast2fqfilename\n'); 
            fns = mlcaster.CellCaster.cellcast(this.imagingObject, 'fqfilename');
        end
        function A    = cast2numerics(this)
            dprintf('inside CellCaster.cast2numerics\n'); 
            A = mlcaster.CellCaster.cellcast(this.imagingObject, 'single');
        end
        function nii  = cast2NIfTI(this)
            dprintf('inside CellCaster.cast2NIfTI\n'); 
            nii = mlcaster.CellCaster.cellcast(this.imagingObject, 'mlfourd.NIfTI');
        end
        function niib = cast2NiiBrowser(this)
            dprintf('inside CellCaster.cast2NiiBrowser\n');
            niib = mlcaster.CellCaster.cellcast(this.imagingObject, 'mlfourd.NiiBrowser');
        end
        function ic   = cast2ImagingComponent(this)
            dprintf('inside CellCaster.cast2ImagingComponent\n'); 
            ic = mlcaster.CellCaster.cell2ImagingComponent(this.imagingObject);
        end
    end 
end

