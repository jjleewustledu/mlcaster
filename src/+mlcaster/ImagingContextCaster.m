classdef ImagingContextCaster < mlcaster.CasterStrategy
	%% IMAGINGCONTEXTCASTER   

	%  $Revision: 2626 $ 
 	%  was created $Date: 2013-09-16 01:17:42 -0500 (Mon, 16 Sep 2013) $ 
 	%  by $Author: jjlee $,  
 	%  last modified $LastChangedDate: 2013-09-16 01:17:42 -0500 (Mon, 16 Sep 2013) $ 
 	%  and checked into repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mlcaster/src/+mlcaster/trunk/ImagingContextCaster.m $,  
 	%  developed on Matlab 8.1.0.604 (R2013a) 
 	%  $Id: ImagingContextCaster.m 2626 2013-09-16 06:17:42Z jjlee $ 

    properties (Dependent)
        defaultPath
        imagingObject
        nifti
        niftid
        imcomponent
    end
    
    methods
        function pth   = get.defaultPath(this) 
            pth = fileparts(this.imagingObject.fqfilename);
        end
        function imobj = get.imagingObject(this)
            assert(isa(this.imagingObject_, 'mlfourd.ImagingContext'));
            imobj = this.imagingObject_.clone;
        end
        function nii   = get.nifti(this)
            nii = this.imagingObject.nifti;
        end
        function nii   = get.niftid(this)
            nii = this.imagingObject.niftid;
        end
        function imcmp = get.imcomponent(this)
            imcmp = this.imagingObject.imcomponent;
        end
        
 		function this = ImagingContextCaster(varargin) 
 			%% IMAGINGCONTEXTCASTER 
 			%  Usage:  obj = ImagingContextCaster(image_to_cast) 

 			this = this@mlcaster.CasterStrategy(varargin{:}); 
 		end %  ctor 
    end
    
	methods  (Access = 'protected')
        function fp   = cast2fqfileprefix(this)
            fp = this.imagingObject.fqfileprefix;
        end
        function im   = cast2image(this)
            im = this.imagingObject;
        end
    end 
    
	%  Created with Newcl by John J. Lee after newfcn by Frank Gonzalez-Morphy 
end

