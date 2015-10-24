classdef MGHCaster < mlcaster.CasterStrategy 
	%% MGHCASTER is part of a strategy design pattern with CasterStrategy.
    %  It is DEPRECATED as of 2015 Oct 20.

	%  $Revision$ 
 	%  was created $Date$ 
 	%  by $Author$,  
 	%  last modified $LastChangedDate$ 
 	%  and checked into repository $URL$,  
 	%  developed on Matlab 8.1.0.604 (R2013a) 
 	%  $Id$ 

    properties (Dependent)
        defaultPath
        imagingObject
    end
    
    methods
        function pth   = get.defaultPath(this) 
            pth = fileparts(this.imagingObject.fqfilename);
        end
        function imobj = get.imagingObject(this)
            assert(isa(this.imagingObject_, 'mlsurfer.MGH'));
            imobj = this.imagingObject_;
        end
        
 		function this = MGHCaster(varargin) 
 			%% NIFTICASTER 
 			%  Usage:  obj = MGHCaster(...) % cf. CasterStrategy

 			this = this@mlcaster.CasterStrategy(varargin{:}); 
 		end %  ctor 
    end
    
	methods  (Access = 'protected')
        function fp   = cast2fqfileprefix(this)
            fp = this.imagingObject.fqfileprefix;
        end
        function im   = cast2image(this)
            assert(isa(this.imagingObject, 'mlsurfer.MGH'));
            im = this.imagingObject;
        end
 	end 
	%  Created with Newcl by John J. Lee after newfcn by Frank Gonzalez-Morphy 
end

