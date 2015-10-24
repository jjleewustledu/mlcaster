classdef CharCaster < mlcaster.CasterStrategy
	%% CHARCASTER part of a strategy design pattern with CasterStrategy.
    %  It is DEPRECATED as of 2015 Oct 20.
    
	%  $Revision: 2603 $
 	%  was created $Date: 2013-09-07 19:13:01 -0500 (Sat, 07 Sep 2013) $
 	%  by $Author: jjlee $, 
 	%  last modified $LastChangedDate: 2013-09-07 19:13:01 -0500 (Sat, 07 Sep 2013) $
 	%  and checked into repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mlcaster/src/+mlcaster/trunk/CharCaster.m $, 
 	%  developed on Matlab 8.1.0.604 (R2013a)
 	%  $Id: CharCaster.m 2603 2013-09-08 00:13:01Z jjlee $
 	%  N.B. classdef (Sealed, Hidden, InferiorClasses = {?class1,?class2}, ConstructOnLoad)
    
    properties (Dependent)
        imagingObject
        defaultPath
    end
    
    methods 
        function pth   = get.defaultPath(this)  %#ok<MANU>
            pth = pwd;
        end
        function imobj = get.imagingObject(this)
            assert(ischar(this.imagingObject_));
            if (~lstrfind(this.imagingObject_, '.mgz') && ~lstrfind(this.imagingObject_, '.mgh')) %% KLUDGE
                imobj = filename(this.imagingObject_); return; end
            imobj = this.imagingObject_; 
        end
        
 		function this = CharCaster(varargin) 
 			%% CHARCASTER 
 			%  Usage:  obj = CharCaster() 

 			this = this@mlcaster.CasterStrategy(varargin{:}); 
 		end %  ctor 
    end
    
	methods (Access = 'protected')
        function fp   = cast2fqfileprefix(this)
            [pth,fp] = filepartsx(this.imagingObject, mlfourd.NIfTIInterface.FILETYPE_EXT);
            if (isempty(pth))
                pth = this.defaultPath; end
            fp = fullfile(pth, fp);
        end        
        function im   = cast2image(this)
            im = mlfourd.NIfTI.load([this.cast2fqfileprefix mlfourd.NIfTIInterface.FILETYPE_EXT]);
        end
    end 
    
	%  Created with Newcl by John J. Lee after newfcn by Frank Gonzalez-Morphy 
end

