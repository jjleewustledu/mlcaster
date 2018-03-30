classdef NiiBrowserCaster < mlcaster.CasterStrategy
	%% NIIBROWSERCASTER part of a strategy design pattern with CasterStrategy.
    
	%  $Revision: 2542 $
 	%  was created $Date: 2013-08-19 11:36:23 -0500 (Mon, 19 Aug 2013) $
 	%  by $Author: jjlee $, 
 	%  last modified $LastChangedDate: 2013-08-19 11:36:23 -0500 (Mon, 19 Aug 2013) $
 	%  and checked into repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mlcaster/src/+mlcaster/trunk/NiiBrowserCaster.m $, 
 	%  developed on Matlab 8.1.0.604 (R2013a)
 	%  $Id: NiiBrowserCaster.m 2542 2013-08-19 16:36:23Z jjlee $
 	%  N.B. classdef (Sealed, Hidden, InferiorClasses = {?class1,?class2}, ConstructOnLoad)

    properties (Dependent)
        defaultPath
        imagingObject
    end
    
    methods
        function pth   = get.defaultPath(this) 
            pth = fileparts(this.imagingObject.fqfilename);
        end
        function imobj = get.imagingObject(this)
            imobj = this.imagingObject_;
        end
        
 		function this = NiiBrowserCaster(varargin) 
 			%% NIIBROWSERCASTER 
 			%  Usage:  obj = NiiBrowserCaster() 

 			this = this@mlcaster.CasterStrategy(varargin{:}); 
 		end %  ctor 
    end
    
	methods (Access = 'protected')
        function fp   = cast2fqfileprefix(this)
            assert(isa(this.imagingObject_, 'mlfourd.NiiBrowser'));
            fp = this.imagingObject.fqfileprefix;
        end
        function im   = cast2image(this)
            assert(isa(this.imagingObject, 'mlfourd.NiiBrowser'));
            im = mlfourd.NIfTI(this.imagingObject);
        end
 	end 

	%  Created with Newcl by John J. Lee after newfcn by Frank Gonzalez-Morphy 
end

