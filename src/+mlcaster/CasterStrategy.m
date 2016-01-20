classdef CasterStrategy 
	%% CASTERSTRATEGY is the abstract strategy to a strategy design pattern.
    
	%  $Revision: 2626 $
 	%  was created $Date: 2013-09-16 01:17:42 -0500 (Mon, 16 Sep 2013) $
 	%  by $Author: jjlee $, 
 	%  last modified $LastChangedDate: 2013-09-16 01:17:42 -0500 (Mon, 16 Sep 2013) $
 	%  and checked into repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mlcaster/src/+mlcaster/trunk/CasterStrategy.m $, 
 	%  developed on Matlab 8.1.0.604 (R2013a)
 	%  $Id: CasterStrategy.m 2626 2013-09-16 06:17:42Z jjlee $
 	%  N.B. classdef (Sealed, Hidden, InferiorClasses = {?class1,?class2}, ConstructOnLoad)

    properties (Abstract)
        imagingObject
    end
    
    methods (Static)
        function strat = newStrategy(imobj)
            import mlcaster.*;
            ip = inputParser;
            addRequired(ip, 'imobj', @CasterStrategy.isSupportedImage);
            parse(ip, imobj);
            
            switch (class(ip.Results.imobj))
                case 'cell'
                    strat = CellCaster(ip.Results.imobj);
                case 'char'
                    if (lstrfind(ip.Results.imobj, '*'))
                        strat = CellCaster(ip.Results.imobj);
                        return
                    end
                    strat = CharCaster(ip.Results.imobj);
                case numeric_types
                    strat = NumericCaster(ip.Results.imobj);
                case 'mlfourd.NIfTI'
                    strat = NIfTICaster(ip.Results.imobj); 
                case 'mlfourd.NiiBrowser'
                    strat = NiiBrowserCaster(ip.Results.imobj);
                case 'mlfourd.NIfTId'
                    strat = NIfTIdCaster(ip.Results.imobj); 
                case 'mlsurfer.MGH'
                    strat = MGHCaster(ip.Results.imobj);
                case 'mlfourd.ImagingContext'
                    strat = ImagingContextCaster(ip.Results.imobj);
                otherwise
                    if (isa(ip.Results.imobj, 'mlfourd.ImagingComponent'))
                        strat = ImagingComponentCaster(ip.Results.imobj); 
                        return
                    end
                    error('mlcaster:unsupportedTypeClass', 'class(CasterStrategy.newStrategy.im)->%s', class(ip.Results.imobj));
            end
        end
        function tf    = isSupportedType(tn)
            if (lstrfind(tn, mlchoosers.ImagingChoosers.SUPPORTED_IMAGE_TYPES))
                tf = true;
            else
                tf = false;
            end
        end
        function tf    = isSupportedImage(im)
            tf = mlcaster.CasterStrategy.isSupportedType(class(im));
        end
    end
    
    methods
        function imobj = castto(this, newtyp)
            import mlcaster.*;
            ip = inputParser;
            addOptional(ip, 'newtyp', 'fqfilename', @CasterStrategy.isSupportedType)
            parse(ip, newtyp);
            
            switch (ip.Results.newtyp)
                case  'fileprefix'
                    imobj = this.cast2fileprefix;
                case  'filename'
                    imobj = this.cast2filename;
                case  'fqfileprefix'
                    imobj = this.cast2fqfileprefix;
                case {'fqfilename' 'char'}
                    imobj = this.cast2fqfilename;
                case  numeric_types
                    imobj = this.cast2numeric;
                case  {'mlfourd.NIfTI' 'NIfTI'}
                    imobj = this.cast2NIfTI;
                case  {'mlfourd.NIfTId' 'NIfTId'}
                    imobj = this.cast2NIfTId;
                case  {'mlfourd.NiiBrowser' 'NiiBrowser'}
                    imobj = this.cast2NiiBrowser;
                case  {'mlsurfer.MGH' 'MGH'}
                    imobj = this.cast2MGH;
                case  {'mlfourd.ImagingComponent' 'mlfourd.ImagingSeries' 'mlfourd.ImagingComposite' ...
                               'ImagingComponent'         'ImagingSeries'         'ImagingComposite'}
                    imobj = this.cast2ImagingComponent;
                case  'mlfourd.ImagingContext'
                    imobj = this.cast2ImagingContext;
                otherwise
                    error('mlfourd:unsupportedParamValue', 'CasterStrategy.p.Results.newtyp->%s', ip.Results.newtyp);
            end
        end               
    end
    
    %% PROTECTED
    
    methods (Abstract, Access = 'protected')
        cast2fqfileprefix(this)
        cast2image(this)
    end
    
    properties (Access = 'protected')
        imagingObject_
    end
    
    methods (Static, Access = 'protected')
        function im   = image2numeric(im)
            if (~isnumeric(im))
                im = mlcaster.CasterStrategy.image2NIfTId(im);
                im = im.img;
            end
        end        
        function im   = image2NIfTI(im)
            if (~isa(im, 'mlfourd.NIfTI'));
                im = mlfourd.NIfTI( ...
                    mlcaster.CasterStrategy.image2NIfTId(im));
            end
        end
        function im   = image2NiiBrowser(im)
            if (~isa(im, 'mlfourd.NiiBrowser'))
                im = mlfourd.NiiBrowser( ...
                    mlcaster.CasterStrategy.image2NIfTI(im));
            end
        end  
        function niid = image2NIfTId(im)
            import mlfourd.*;
            if (isnumeric(im))
                niid = NIfTId(im, ...
                    sprintf('CasterStrategy_image2NIfTId_D%s', datestr(now,30))); 
                return
            end
            if (isa(im, 'mlsurfer.MGH'))
                niid = im.niftid;
                return
            end
            if (isa(im, 'mlfourd.ImagingContext'))
                niid = im.niftid; 
                return
            end
            if (isa(im, 'mlfourd.ImagingComponent'))
                niid = NIfTId(im.cached); 
                return
            end
            niid = NIfTId(im);
        end   
        function im   = image2MGH(im)
            if (~isa(im, 'mlsurfer.MGH'))
                im = mlsurfer.MGH( ...
                    mlcaster.CasterStrategy.image2NIfTId(im));
                return
            end
        end
        function im   = image2ImagingContext(im)
            if (~isa(im, 'mlfourd.ImagingContext'))
                im = mlfourd.ImagingContext( ...
                    mlcaster.CasterStrategy.image2NIfTId(im));
                return
            end
        end
        function im   = image2ImagingComponent(im)
            if (~isa(im, 'mlfourd.ImagingComponent'))                
                im = mlfourd.ImagingComponent.load( ...
                    mlcaster.CasterStrategy.image2NIfTId(im));
                return
            end
        end
    end
    
    methods (Access = 'protected')
        function fp   = cast2fileprefix(this)
            [~,fp] = fileparts(this.cast2fqfileprefix);
        end
        function fn   = cast2filename(this)
            [~,fn,e] = fileparts(this.cast2fqfilename);
            fn = [fn e];
        end
        function fn   = cast2fqfilename(this)
            fn = [this.cast2fqfileprefix mlfourd.INIfTI.FILETYPE_EXT];
        end
        function A    = cast2numeric(this)
            A = this.image2numeric(this.cast2image);
        end
        function nii  = cast2NIfTI(this)
            nii = this.image2NIfTI(this.cast2image);
        end
        function niib = cast2NiiBrowser(this)
            niib = this.image2NiiBrowser(this.cast2image);
        end
        function dnii = cast2NIfTId(this)
            dnii = this.image2NIfTId(this.cast2image);
        end
        function mgh  = cast2MGH(this)
            mgh = this.image2MGH(this.cast2image);
        end
        function im   = cast2ImagingContext(this)
            im = this.image2ImagingContext(this.imagingObject);
        end
        function im   = cast2ImagingComponent(this)
            im = this.image2ImagingComponent(this.cast2image);
        end  
        
        function this = CasterStrategy(imobj)
            assert(mlcaster.CasterStrategy.isSupportedImage(imobj));
            this.imagingObject_ = imobj;
        end
    end

	%  Created with Newcl by John J. Lee after newfcn by Frank Gonzalez-Morphy 
end

