classdef CasterStrategy 
	%% CASTERSTRATEGY abstract strategy to a strategy design pattern
    
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
            p = inputParser;
            import mlcaster.*;
            addRequired(p, 'imobj', @CasterStrategy.isSupportedImage);
            parse(p, imobj);
            switch (class(p.Results.imobj))
                case 'cell'
                    strat = CellCaster(p.Results.imobj);
                case 'char'
                    if (lstrfind(p.Results.imobj, '*'))
                        strat = CellCaster(p.Results.imobj);
                        return
                    end
                    strat = CharCaster(p.Results.imobj);
                case numeric_types
                    strat = NumericCaster(p.Results.imobj);
                case 'mlfourd.NiiBrowser'
                    strat = NiiBrowserCaster(p.Results.imobj);
                case 'mlsurfer.MGH'
                    strat = MGHCaster(p.Results.imobj);
                case 'mlfourd.ImagingContext'
                    strat = ImagingContextCaster(p.Results.imobj);
                case 'mlfourd.NIfTI'
                    strat = NIfTICaster(p.Results.imobj); 
                case 'mlfourd.BlurredNIfTI'
                    strat = BlurredNIfTICaster(p.Results.imobj);
                otherwise
                    if (isa(p.Results.imobj, 'mlfourd.ImagingComponent'))
                        strat = ImagingComponentCaster(p.Results.imobj); return; end
                    error('mlcaster:unsupportedTypeClass', 'class(CasterStrategy.newStrategy.im)->%s', class(p.Results.imobj));
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
            p = inputParser;
            import mlcaster.*;
            addOptional(p, 'newtyp', 'fqfilename', @CasterStrategy.isSupportedType)
            parse(p, newtyp);
            switch (p.Results.newtyp)
                case  'filename'
                    imobj = this.cast2filename;
                case  'fileprefix'
                    imobj = this.cast2fileprefix;
                case {'fqfilename' 'char'}
                    imobj = this.cast2fqfilename;
                case  'fqfileprefix'
                    imobj = this.cast2fqfileprefix;
                case  numeric_types
                    imobj = this.cast2numeric;
                case  {'mlfourd.NIfTI' 'NIfTI'}
                    imobj = this.cast2NIfTI;
                case  {'mlfourd.BlurredNIfTI' 'BlurredNIfTI'}
                    imobj = this.cast2BlurredNIfTI;
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
                    error('mlfourd:unsupportedParamValue', 'CasterStrategy.p.Results.newtyp->%s', p.Results.newtyp);
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
        function A    = image2numeric(im)
            im = mlcaster.CasterStrategy.image2NIfTI(im);
            A  = im.img;
        end        
        function nii  = image2NIfTI(im)
            if (isa(im, 'mlfourd.ImagingContext'))
                nii = im.nifti; return; end
            if (isa(im, 'mlfourd.ImagingComponent'))
                nii = im.cachedNext; return; end
            assert(isa(im, 'mlfourd.NIfTI'));
            nii = im;
        end
        function bnii  = image2BlurredNIfTI(im)
            import mlfourd.*;
            if (isa(im, 'mlfourd.ImagingContext'))
                bnii = BlurredNIfTI(im.nifti); return; end
            if (isa(im, 'mlfourd.ImagingComponent'))
                bnii = BlurredNIfTI(im.cachedNext); return; end
            assert(isa(im, 'mlfourd.NIfTIInterface'));
            bnii     = BlurredNIfTI(im);
        end
        function niib = image2NiiBrowser(im)
            niib = mlfourd.NiiBrowser( ...
                mlcaster.CasterStrategy.image2NIfTI(im));
        end     
        function mgh  = image2MGH(im)
            if (isa(im, 'mlfourd.NIfTIInterface'))
                mgh = mlsurfer.MGH(im); return; end
            if (isa(im, 'mlfourd.ImagingContext'))
                mgh = im.mgh; return; end
            assert(isa(im, 'mlsurfer.MGH'));
            mgh = im;
        end
        function ic   = image2ImagingComponent(im)
            if (isa(im, 'mlfourd.ImagingContext'))
                ic = im.imcomponent; return; end
            if (isa(im, 'mlfourd.ImagingComponent'))
                ic = im; return; end
            ic = mlfourd.ImagingComponent.load( ...
                 mlcaster.CasterStrategy.image2NIfTI(im));
        end
        function ic   = image2ImagingContext(im)
            if (isa(im, 'mlfourd.ImagingContext'))
                ic = im; return; end
            ic = mlfourd.ImagingContext.load(im);
        end
    end
    
    methods (Access = 'protected')
        function fn   = cast2filename(this)
            [~,fn,e] = fileparts(this.cast2fqfilename);
            fn = [fn e];
        end
        function fn   = cast2fqfilename(this)
            fn = [this.cast2fqfileprefix mlfourd.NIfTIInterface.FILETYPE_EXT];
        end
        function fp   = cast2fileprefix(this)
            [~,fp] = fileparts(this.cast2fqfileprefix);
        end
        function A    = cast2numeric(this)
            import mlcaster.*; 
            A = this.image2numeric(this.cast2image);
            assert(isnumeric_type(A));
        end
        function nii  = cast2NIfTI(this)
            import mlcaster.*; 
            nii = this.image2NIfTI(this.cast2image);
            assert(isa(nii, 'mlfourd.NIfTIInterface'));
        end
        function bnii = cast2BlurredNIfTI(this)
            import mlcaster.*; 
            bnii = this.image2BlurredNIfTI(this.cast2image);
            assert(isa(bnii, 'mlfourd.BlurredNIfTI'));
        end
        function niib = cast2NiiBrowser(this)
            import mlcaster.*; 
            niib = this.image2NiiBrowser(this.cast2image);
            assert(isa(niib, 'mlfourd.NiiBrowser'));
        end
        function mgh  = cast2MGH(this)
            import mlcaster.*; 
            mgh = this.image2MGH(this.cast2image);
            assert(isa(mgh, 'mlsurfer.MGH'));
        end
        function im   = cast2ImagingComponent(this)
            im = this.image2ImagingComponent(this.cast2image);
            assert(isa(im, 'mlfourd.ImagingComponent'));
        end  
        function im   = cast2ImagingContext(this)
            import mlcaster.*;
            im = this.image2ImagingContext(this.imagingObject);
            assert(isa(im, 'mlfourd.ImagingContext'));
        end
        
        function this = CasterStrategy(imobj)
            assert(mlcaster.CasterStrategy.isSupportedImage(imobj));
            this.imagingObject_ = imobj;
        end
    end

	%  Created with Newcl by John J. Lee after newfcn by Frank Gonzalez-Morphy 
end

