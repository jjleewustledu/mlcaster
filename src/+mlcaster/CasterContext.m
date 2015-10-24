classdef CasterContext < handle
    %% CASTERCONTEXT provides the context of a strategy design pattern with CasterStrategy,
    %  dispatching properties & methods to concrete classes that subclass CasterStrategy.
    %  Castercontext must be handle so as to allow run-time changes of concrete strategies.
    %  It is DEPRECATED as of 2015 Oct 20.
    
    %  $Revision: 2626 $
    %  was created $Date: 2013-09-16 01:17:42 -0500 (Mon, 16 Sep 2013) $
    %  by $Author: jjlee $,
    %  last modified $LastChangedDate: 2013-09-16 01:17:42 -0500 (Mon, 16 Sep 2013) $
    %  and checked into repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mlcaster/src/+mlcaster/trunk/CasterContext.m $,
    %  developed on Matlab 8.1.0.604 (R2013a)
    %  $Id: CasterContext.m 2626 2013-09-16 06:17:42Z jjlee $
    %  N.B. classdef (Sealed, Hidden, InferiorClasses = {?class1,?class2}, ConstructOnLoad)

    properties (Dependent)
        casterImage
        strategy
    end
    
    methods (Static)
        function imobj = imcast(imobj, newtyp)
            %% IMCAST casts passed image to a requested type, double array is default
            %  p = imcast(p, typ)
            %             ^ image-object:  fileprefix, filename, ...
            %                              numeric, ...
            %                              mlpatterns.ValueList, mlfourd.NIfTI, mlfourd.NiiBrowser, ...
            %                ^ target type named as string
            %                  e. g.:  char, numeric_types, abstract_image_types
            %  ^ image-object casted to target type
            
            if (isa(imobj, newtyp))
                return; 
            end
            contxt = mlcaster.CasterContext(imobj);
            imobj  = contxt.castto(newtyp);
        end
    end
    
    methods %% SET/GET
        function        set.casterImage(this, imobj)
            this.strategy_ = mlcaster.CasterStrategy.newStrategy(imobj);
        end
        function cstr = get.strategy(this)
            assert(isa(this.strategy_, 'mlcaster.CasterStrategy'));
            cstr = this.strategy_;
        end
    end
    
    methods
        function im   = castto(this, newtyp) 
            %% CASTTO delegates to internal strategy
            
            im = this.strategy.castto(newtyp);
        end
        function this = CasterContext(imobj)
            this.casterImage = imobj;
        end        
    end
    
    properties (Access = 'private')
        strategy_
    end
    
    %  Created with Newcl by John J. Lee after newfcn by Frank Gonzalez-Morphy
end

