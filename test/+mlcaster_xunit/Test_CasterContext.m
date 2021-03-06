classdef Test_CasterContext < MyTestCase
	%% TEST_CASTERCONTEXT 
	%  Usage:  >> runtests tests_dir 
	%          >> runtests mlcaster.Test_CasterContext % in . or the matlab path
	%          >> runtests mlcaster.Test_CasterContext:test_nameoffunc
	%          >> runtests(mlcaster.Test_CasterContext, Test_Class2, Test_Class3, ...)
	%  See also:  package xunit

	%  $Revision: 2640 $
 	%  was created $Date: 2013-09-21 17:58:17 -0500 (Sat, 21 Sep 2013) $
 	%  by $Author: jjlee $, 
 	%  last modified $LastChangedDate: 2013-09-21 17:58:17 -0500 (Sat, 21 Sep 2013) $
 	%  and checked into repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mlcaster/test/+mlcaster_xunit/trunk/Test_CasterContext.m $, 
 	%  developed on Matlab 8.1.0.604 (R2013a)
 	%  $Id: Test_CasterContext.m 2640 2013-09-21 22:58:17Z jjlee $
 	%  N.B. classdef (Sealed, Hidden, InferiorClasses = {?class1,?class2}, ConstructOnLoad)

	properties (Dependent)
        aChar
        aNumeric
        aNIfTI
        aNiiBrowser
        anImagingComponent
    end

    properties (Dependent, Hidden)
        theNIfTI
    end
    
    methods %% SET/GET
        function c = get.aChar(this)
            c = this.t1_fqfn;
        end
        function n = get.aNumeric(this)
            n = this.theNIfTI.img;
        end
        function nb = get.aNIfTI(this)
            nb = this.theNIfTI;
        end
        function nb = get.aNiiBrowser(this)
            nb = mlfourd.NiiBrowser(this.theNIfTI);
        end
        function ic = get.anImagingComponent(this)
            ic = mlfourd.ImagingComponent.load(this.theNIfTI);
        end
        function nii = get.theNIfTI(this)
            if (isempty(this.theNIfTI_))
                this.theNIfTI_ = mlfourd.NIfTI.load(this.t1_fqfn); end
            nii = this.theNIfTI_;
        end
    end
    
	methods 
 		function test_imcast_char2fileprefix(this) 
            import mlcaster.*;
 			assertEqual(this.t1_fp, CasterContext.imcast(this.aChar, 'fileprefix'));
        end 
 		function test_imcast_char2filename(this) 
            import mlcaster.*;
 			assertEqual([this.t1_fp '.nii.gz'], ...
                        CasterContext.imcast(this.aChar, 'filename'));
        end 
 		function test_imcast_char2fqfileprefix(this) 
            import mlcaster.*;
 			assertEqual(fileprefix(this.aChar, '.nii.gz'), ...
                        CasterContext.imcast(this.aChar, 'fqfileprefix'));
        end 
 		function test_imcast_char2fqfilename(this) 
            import mlcaster.*;
 			assertEqual(this.aChar, ...
                CasterContext.imcast(this.aChar, 'fqfilename'));
        end         
        function test_imcast_char2numeric(this)
            import mlcaster.*;
            assertEqual(this.aNumeric, ...
                CasterContext.imcast(this.aChar, 'double'));
        end
        function test_imcast_char2nifti(this)
            import mlcaster.*;
            this.assertObjectsEqual(this.aNIfTI, ...
                CasterContext.imcast(this.aChar, 'mlfourd.NIfTI'));
        end
        function test_imcast_char2niibrowser(this)
            import mlcaster.*;
            this.assertObjectsEqual(this.aNiiBrowser, ...
                CasterContext.imcast(this.aChar, 'mlfourd.NiiBrowser'));
        end
        function test_imcast_char2imagingcomponent(this)
            import mlcaster.*;
            this.assertObjectsEqual(this.anImagingComponent, ...
                CasterContext.imcast(this.aChar, 'mlfourd.ImagingComponent'));
        end
        
        function test_imcast_numeric2fileprefix(this)
            import mlcaster.*;
            this.subtest_fileprefix(CasterContext.imcast(this.aNumeric, 'fileprefix'));
        end
        function test_imcast_numeric2filename(this)
            import mlcaster.*;
            this.subtest_filename(CasterContext.imcast(this.aNumeric, 'filename'));
        end
        function test_imcast_numeric2fqfileprefix(this)
            import mlcaster.*;
            this.subtest_fqfileprefix(CasterContext.imcast(this.aNumeric, 'fqfileprefix'));
        end
        function test_imcast_numeric2fqfilename(this)
            import mlcaster.*;
            this.subtest_fqfilename(CasterContext.imcast(this.aNumeric, 'fqfilename'));
        end
        function test_imcast_numeric2nifti(this)
            import mlcaster.*;
 			assertTrue(isa(CasterContext.imcast(this.aNumeric, 'mlfourd.NIfTI'), 'mlfourd.NIfTIInterface'));
        end
        function test_imcast_numeric2niibrowser(this)
            import mlcaster.*;
 			assertTrue(isa(CasterContext.imcast(this.aNumeric, 'mlfourd.NiiBrowser'), 'mlfourd.NiiBrowser'));
        end
        function test_imcast_numeric2imagingcomponent(this)
            import mlcaster.*;
 			assertTrue(isa(CasterContext.imcast(this.aNumeric, 'mlfourd.ImagingComponent'), 'mlfourd.ImagingComponent'));
        end
        
        function test_imcast_nifti2fileprefix(this)
            import mlcaster.*;
            this.subtest_fileprefix(CasterContext.imcast(this.aNIfTI, 'fileprefix'));
        end
        function test_imcast_nifti2filename(this)
            import mlcaster.*;
            this.subtest_filename(CasterContext.imcast(this.aNIfTI, 'filename'));
        end
        function test_imcast_nifti2fqfileprefix(this)
            import mlcaster.*;
            this.subtest_fqfileprefix(CasterContext.imcast(this.aNIfTI, 'fqfileprefix'));
        end
        function test_imcast_nifti2fqfilename(this)
            import mlcaster.*;
            this.subtest_fqfilename(CasterContext.imcast(this.aNIfTI, 'fqfilename'));
        end
        function test_imcast_nifti2numeric(this)
            import mlcaster.*;
 			assertTrue(isnumeric(CasterContext.imcast(this.aNIfTI, 'double')));
        end
        function test_imcast_nifti2niibrowser(this)
            import mlcaster.*;
 			assertTrue(isa(CasterContext.imcast(this.aNIfTI, 'mlfourd.NiiBrowser'), 'mlfourd.NiiBrowser'));
        end
        function test_imcast_nifti2imagingcomponent(this)
            import mlcaster.*;
 			assertTrue(isa(CasterContext.imcast(this.aNIfTI, 'mlfourd.ImagingComponent'), 'mlfourd.ImagingComponent'));
        end
        
        function test_imcast_niibrowser2numeric(this)
            import mlcaster.*;
 			assertTrue(isnumeric(CasterContext.imcast(this.aNiiBrowser, 'double')));
        end
        function test_imcast_niibrowser2nifti(this)
            import mlcaster.*;
 			assertTrue(isa(CasterContext.imcast(this.aNiiBrowser, 'mlfourd.NIfTI'), 'mlfourd.NIfTIInterface'));
        end
        function test_imcast_niibrowser2imagingcomponent(this)
            import mlcaster.*;
 			assertTrue(isa(CasterContext.imcast(this.aNiiBrowser, 'mlfourd.ImagingComponent'), 'mlfourd.ImagingComponent'));
        end
        
        function test_imcast_imagingcomponent2numeric(this)
            import mlcaster.*;
 			assertTrue(isnumeric(CasterContext.imcast(this.anImagingComponent, 'double')));
        end
        function test_imcast_imagingcomponent2nifti(this)
            import mlcaster.*;
 			assertTrue(isa(CasterContext.imcast(this.anImagingComponent, 'mlfourd.NIfTI'), 'mlfourd.NIfTIInterface'));
        end
        function test_imcast_imagingcomponent2niibrowser(this)
            import mlcaster.*;
 			assertTrue(isa(CasterContext.imcast(this.anImagingComponent, 'mlfourd.NiiBrowser'), 'mlfourd.NiiBrowser'));
        end
        
%%        function test_imcast_wildcard(this)
%%            assertEqual({'t2_006' 't2_006_on_t1_005' 't2_006_on_t1_005' 't2_007' 't2_007_on_t1_005' 't2_007_on_t1_005'}, ...
%%                         mlcaster.CasterContext.imcast(fullfile(this.fslPath, 't2*'), 'fileprefix'));
%%        end
%%        function test_imcast_cell(this)
%%            flist = mlcaster.CasterContext.imcast(fullfile(this.fslPath, '*t1*.nii.gz'), 'fqfilename');
%%            %cellstr(flist)
%%            assertEqual(this.imcastCellResult_, flist);
%%        end
        
 		function this = Test_CasterContext(varargin) 
 			this = this@MyTestCase(varargin{:}); 
            mlbash(sprintf('rm %s', fullfile(this.fslPath, '*.nii')));
        end % ctor 
    end 
    
    %% PROTECTED
    
    methods (Access = 'protected') 
        function subtest_fileprefix(~, fp) 
 			assertTrue(ischar(fp));
            assertTrue(isempty(fileparts(fp)));
            [~,~,e] = filepartsx(fp, '.nii.gz');
            assertTrue(isempty(e));
        end
        function subtest_filename(~, fn)
 			assertTrue(ischar(fn));
            assertTrue(isempty(fileparts(fn)));
            [~,~,e] = filepartsx(fn, '.nii.gz');
            assertTrue(strcmp('.nii.gz', e));
        end
        function subtest_fqfileprefix(~, fqfp)
 			assertTrue(ischar(fqfp));
            assertFalse(isempty(fileparts(fqfp)));
            [~,~,e] = filepartsx(fqfp, '.nii.gz');
            assertTrue(isempty(e));
        end
        function subtest_fqfilename(~, fqfn)
 			assertTrue(ischar(fqfn));
            assertFalse(isempty(fileparts(fqfn)));
            [~,~,e] = filepartsx(fqfn, '.nii.gz');
            assertTrue(strcmp('.nii.gz', e));
        end
        
    end
    
    %% PRIVATE
    
    properties (Access = 'private')
        theNIfTI_
        imcastCellResult_ = {
    '/Volumes/SeagateBP/Local/test/np755/mm01-020_p7377_2009feb5/fsl/bt1_005.nii.gz' ...
    '/Volumes/SeagateBP/Local/test/np755/mm01-020_p7377_2009feb5/fsl/bt1_005_inskull_mask.nii.gz' ...
    '/Volumes/SeagateBP/Local/test/np755/mm01-020_p7377_2009feb5/fsl/bt1_005_inskull_mesh.nii.gz' ...
    '/Volumes/SeagateBP/Local/test/np755/mm01-020_p7377_2009feb5/fsl/bt1_005_mask.nii.gz' ...
    '/Volumes/SeagateBP/Local/test/np755/mm01-020_p7377_2009feb5/fsl/bt1_005_outskin_mask.nii.gz' ...
    '/Volumes/SeagateBP/Local/test/np755/mm01-020_p7377_2009feb5/fsl/bt1_005_outskin_mesh.nii.gz' ...
    '/Volumes/SeagateBP/Local/test/np755/mm01-020_p7377_2009feb5/fsl/bt1_005_outskull_mask.nii.gz' ...
    '/Volumes/SeagateBP/Local/test/np755/mm01-020_p7377_2009feb5/fsl/bt1_005_outskull_mesh.nii.gz' ...
    '/Volumes/SeagateBP/Local/test/np755/mm01-020_p7377_2009feb5/fsl/bt1_005_overlay.nii.gz' ...
    '/Volumes/SeagateBP/Local/test/np755/mm01-020_p7377_2009feb5/fsl/bt1_005_skull_mask.nii.gz' ...
    '/Volumes/SeagateBP/Local/test/np755/mm01-020_p7377_2009feb5/fsl/cho_f5to24_on_t1_005.nii.gz' ...
    '/Volumes/SeagateBP/Local/test/np755/mm01-020_p7377_2009feb5/fsl/cho_f5to24_on_t1_005_gauss4p6855.nii.gz' ...
    '/Volumes/SeagateBP/Local/test/np755/mm01-020_p7377_2009feb5/fsl/cho_f5to24_on_t1_005_gauss4p6855m.nii.gz' ...
    '/Volumes/SeagateBP/Local/test/np755/mm01-020_p7377_2009feb5/fsl/cho_f5to24_susan5p52mm_on_t1_005.nii.gz' ...
    '/Volumes/SeagateBP/Local/test/np755/mm01-020_p7377_2009feb5/fsl/coo_f7to26_on_t1_005.nii.gz' ...
    '/Volumes/SeagateBP/Local/test/np755/mm01-020_p7377_2009feb5/fsl/coo_f7to26_on_t1_005_gauss4p6855.nii.gz' ...
    '/Volumes/SeagateBP/Local/test/np755/mm01-020_p7377_2009feb5/fsl/coo_f7to26_on_t1_005_gauss4p6855m.nii.gz' ...
    '/Volumes/SeagateBP/Local/test/np755/mm01-020_p7377_2009feb5/fsl/coo_f7to26_susan5p52mm_on_t1_005.nii.gz' ...
    '/Volumes/SeagateBP/Local/test/np755/mm01-020_p7377_2009feb5/fsl/coo_f7to26cho_f5to24_on_t1_005.nii.gz' ...
    '/Volumes/SeagateBP/Local/test/np755/mm01-020_p7377_2009feb5/fsl/dwi_002_on_t1_005.nii.gz' ...
    '/Volumes/SeagateBP/Local/test/np755/mm01-020_p7377_2009feb5/fsl/epi_017_on_t1_005.nii.gz' ...
    '/Volumes/SeagateBP/Local/test/np755/mm01-020_p7377_2009feb5/fsl/poc_on_t1_005.nii.gz' ...
    '/Volumes/SeagateBP/Local/test/np755/mm01-020_p7377_2009feb5/fsl/poc_susan5p52mm_on_t1_005.nii.gz' ...
    '/Volumes/SeagateBP/Local/test/np755/mm01-020_p7377_2009feb5/fsl/ptr_on_t1_005.nii.gz' ...
    '/Volumes/SeagateBP/Local/test/np755/mm01-020_p7377_2009feb5/fsl/t1_005.nii.gz' ...
    '/Volumes/SeagateBP/Local/test/np755/mm01-020_p7377_2009feb5/fsl/t1_005_gauss4p69mm.nii.gz' ...
    '/Volumes/SeagateBP/Local/test/np755/mm01-020_p7377_2009feb5/fsl/t1_saveas.nii.gz' ...
    '/Volumes/SeagateBP/Local/test/np755/mm01-020_p7377_2009feb5/fsl/t2_006.nii.gz' ...    
    '/Volumes/SeagateBP/Local/test/np755/mm01-020_p7377_2009feb5/fsl/t2_006_on_t1_005.nii.gz' ...
    '/Volumes/SeagateBP/Local/test/np755/mm01-020_p7377_2009feb5/fsl/t2_007.nii.gz' ...   
    '/Volumes/SeagateBP/Local/test/np755/mm01-020_p7377_2009feb5/fsl/t2_007_on_t1_005.nii.gz' ...

            };
    end

	%  Created with Newcl by John J. Lee after newfcn by Frank Gonzalez-Morphy 
end

