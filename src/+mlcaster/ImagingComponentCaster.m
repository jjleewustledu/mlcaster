classdef ImagingComponentCaster < mlcaster.CasterStrategy
	%% IMAGINGCOMPONENTCASTER part of a strategy design pattern with CasterStrategy.
    %  It is DEPRECATED as of 2015 Oct 20.
    
	%  $Revision: 2626 $
 	%  was created $Date: 2013-09-16 01:17:42 -0500 (Mon, 16 Sep 2013) $
 	%  by $Author: jjlee $, 
 	%  last modified $LastChangedDate: 2013-09-16 01:17:42 -0500 (Mon, 16 Sep 2013) $
 	%  and checked into repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mlcaster/src/+mlcaster/trunk/ImagingComponentCaster.m $, 
 	%  developed on Matlab 8.1.0.604 (R2013a)
 	%  $Id: ImagingComponentCaster.m 2626 2013-09-16 06:17:42Z jjlee $
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
            assert(isa(this.imagingObject_, 'mlfourd.ImagingComponent'));
            imobj = this.imagingObject_.clone;
        end
        function iter  = createIterator(this)
            iter = this.imagingObject.createIterator;
        end
        
 		function this = ImagingComponentCaster(varargin) 
 			%% IMAGINGCOMPONENTCASTER 
 			%  Usage:  obj = ImagingComponentCaster() 

 			this = this@mlcaster.CasterStrategy(varargin{:}); 
 		end %  ctor 
    end
    
	methods (Access = 'protected')
        function fp    = cast2fqfileprefix(this)
            fp = this.imagingObject.fqfileprefix;
        end
        function im    = cast2image(this)
            im = this.imagingObject;
        end
        function nElts = length(this)
            nElts = this.imagingObject.length;
        end
        function tf    = isempty(this)
            tf = this.imagingObject.isempty;
        end
        function this  = add(this, varargin)
            this = this.imagingObject.add(varargin{:});
        end
        function elts  = get(this, locs)
            elts = this.imagingObject.get(locs);
        end
        function this  = remove(this, locs)
            this.imagingObject = this.imagingObject.remove(locs);
        end
        function cnt   = countOf(this, elt)
            cnt = this.imagingObject.countOf(elt);
        end
        function iter  = createIterator(this)
            iter = this.imagingObject.createIterator;
        end
        function locs  = locationsOf(this, elt)
            locs = this.imagingObject.locationsOf(elt);
        end
        function kludg = reset(this)
            kludg = this.imagingObject.reset;
        end
        function tf    = hasNext(this)
            tf = this.imagingObject.hasNext;
        end
        function this  = iterateNext(this)
            this = this.imagingObject.iterateNext;
        end
 	end 

	%  Created with Newcl by John J. Lee after newfcn by Frank Gonzalez-Morphy 
end

