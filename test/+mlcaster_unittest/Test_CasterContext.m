classdef Test_CasterContext < mlfourd_unittest.Test_mlfourd
	%% TEST_CASTERCONTEXT 

	%  Usage:  >> results = run(mlcaster_unittest.Test_CasterContext)
 	%          >> result  = run(mlcaster_unittest.Test_CasterContext, 'test_dt')
 	%  See also:  file:///Applications/Developer/MATLAB_R2014b.app/help/matlab/matlab-unit-test-framework.html

	%  $Revision$
 	%  was created 20-Oct-2015 01:51:47
 	%  by jjlee,
 	%  last modified $LastChangedDate$
 	%  and checked into repository /Users/jjlee/Local/src/mlcvl/mlcaster/test/+mlcaster_unittest.
 	%% It was developed on Matlab 8.5.0.197613 (R2015a) for MACI64.
 	
	properties
 		testObj
 	end

	properties (Dependent)
        aChar
        aNumeric
        aNIfTI
        aNIfTId
        aNiiBrowser
    end

    properties (Dependent, Hidden)
        theNIfTI
        theNIfTId
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
        function nb = get.aNIfTId(this)
            nb = this.theNIfTId;
        end
        function nb = get.aNiiBrowser(this)
            nb = mlfourd.NiiBrowser(this.theNIfTI);
        end
        function nii = get.theNIfTI(this)
            if (isempty(this.theNIfTI_))
                this.theNIfTI_ = mlfourd.NIfTI.load(this.t1_fqfn); end
            nii = this.theNIfTI_;
        end
        function nii = get.theNIfTId(this)
            if (isempty(this.theNIfTId_))
                this.theNIfTId_ = mlfourd.NIfTId.load(this.t1_fqfn); end
            nii = this.theNIfTId_;
        end
    end
    
	methods (Test) 		
 		function test_imcast_char2fileprefix(this) 
            import mlcaster.*;
 			this.verifyEqual(this.t1_fp, CasterContext.imcast(this.aChar, 'fileprefix'));
        end 
 		function test_imcast_char2filename(this) 
            import mlcaster.*;
 			this.verifyEqual([this.t1_fp '.nii.gz'], ...
                        CasterContext.imcast(this.aChar, 'filename'));
        end 
 		function test_imcast_char2fqfileprefix(this) 
            import mlcaster.*;
 			this.verifyEqual(fileprefix(this.aChar, '.nii.gz'), ...
                        CasterContext.imcast(this.aChar, 'fqfileprefix'));
        end 
 		function test_imcast_char2fqfilename(this) 
            import mlcaster.*;
 			this.verifyEqual(this.aChar, ...
                CasterContext.imcast(this.aChar, 'fqfilename'));
        end         
        function test_imcast_char2numeric(this)
            import mlcaster.*;
            this.verifyEqual(this.aNumeric, ...
                CasterContext.imcast(this.aChar, 'double'));
        end
        function test_imcast_char2nifti(this)
            import mlcaster.*;
            this.verifyEqual(this.aNIfTI, ...
                CasterContext.imcast(this.aChar, 'mlfourd.NIfTI'));
        end
        function test_imcast_char2niftid(this)
            import mlcaster.*;
            this.verifyEqual(this.aNIfTId, ...
                CasterContext.imcast(this.aChar, 'mlfourd.NIfTId'));
        end
        function test_imcast_char2niibrowser(this)
            import mlcaster.*;
            this.verifyEqual(this.aNiiBrowser, ...
                CasterContext.imcast(this.aChar, 'mlfourd.NiiBrowser'));
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
 			this.verifyTrue(isa(CasterContext.imcast(this.aNumeric, 'mlfourd.NIfTI'), 'mlfourd.NIfTIInterface'));
        end
        function test_imcast_numeric2niftid(this)
            import mlcaster.*;
 			this.verifyTrue(isa(CasterContext.imcast(this.aNumeric, 'mlfourd.NIfTId'), 'mlfourd.INIfTI'));
        end
        function test_imcast_numeric2niibrowser(this)
            import mlcaster.*;
 			this.verifyTrue(isa(CasterContext.imcast(this.aNumeric, 'mlfourd.NiiBrowser'), 'mlfourd.NiiBrowser'));
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
 			this.verifyTrue(isnumeric(CasterContext.imcast(this.aNIfTI, 'double')));
        end
        function test_imcast_nifti2niibrowser(this)
            import mlcaster.*;
 			this.verifyTrue(isa(CasterContext.imcast(this.aNIfTI, 'mlfourd.NiiBrowser'), 'mlfourd.NiiBrowser'));
        end
        function test_imcast_nifti2niftid(this)
            import mlcaster.*;
 			this.verifyTrue(isa(CasterContext.imcast(this.aNIfTI, 'mlfourd.NIfTId'), 'mlfourd.NIfTId'));
        end
        
        function test_imcast_niftid2fileprefix(this)
            import mlcaster.*;
            this.subtest_fileprefix(CasterContext.imcast(this.aNIfTId, 'fileprefix'));
        end
        function test_imcast_niftid2filename(this)
            import mlcaster.*;
            this.subtest_filename(CasterContext.imcast(this.aNIfTId, 'filename'));
        end
        function test_imcast_niftid2fqfileprefix(this)
            import mlcaster.*;
            this.subtest_fqfileprefix(CasterContext.imcast(this.aNIfTId, 'fqfileprefix'));
        end
        function test_imcast_niftid2fqfilename(this)
            import mlcaster.*;
            this.subtest_fqfilename(CasterContext.imcast(this.aNIfTId, 'fqfilename'));
        end
        function test_imcast_niftid2numeric(this)
            import mlcaster.*;
 			this.verifyTrue(isnumeric(CasterContext.imcast(this.aNIfTId, 'double')));
        end
        function test_imcast_niftid2niibrowser(this)
            import mlcaster.*;
 			this.verifyTrue(isa(CasterContext.imcast(this.aNIfTId, 'mlfourd.NiiBrowser'), 'mlfourd.NiiBrowser'));
        end
        function test_imcast_niftid2nifti(this)
            import mlcaster.*;
 			this.verifyTrue(isa(CasterContext.imcast(this.aNIfTId, 'mlfourd.NIfTI'), 'mlfourd.NIfTI'));
        end
        
        function test_imcast_niibrowser2numeric(this)
            import mlcaster.*;
 			this.verifyTrue(isnumeric(CasterContext.imcast(this.aNiiBrowser, 'double')));
        end
        function test_imcast_niibrowser2nifti(this)
            import mlcaster.*;
 			this.verifyTrue(isa(CasterContext.imcast(this.aNiiBrowser, 'mlfourd.NIfTI'), 'mlfourd.NIfTI'));
        end
        function test_imcast_niibrowser2niftid(this)
            import mlcaster.*;
 			this.verifyTrue(isa(CasterContext.imcast(this.aNiiBrowser, 'mlfourd.NIfTId'), 'mlfourd.NIfTId'));
        end
 	end

 	methods (TestClassSetup)
 		function setupCasterContext(this)
            cd(this.fslPath); 
            dt = mlsystem.DirTool(fullfile(this.fslPath, '*.nii'));
            if (dt.length > 0)
                mlbash(sprintf('rm %s', fullfile(this.fslPath, '*.nii')));
            end
 		end
 	end

 	methods (TestMethodSetup)
 	end

    %% PROTECTED
    
    methods (Access = 'protected') 
        function subtest_fileprefix(this, fp) 
 			this.verifyTrue(ischar(fp));
            this.verifyTrue(isempty(fileparts(fp)));
            [~,~,e] = filepartsx(fp, '.nii.gz');
            this.verifyTrue(isempty(e));
        end
        function subtest_filename(this, fn)
 			this.verifyTrue(ischar(fn));
            this.verifyTrue(isempty(fileparts(fn)));
            [~,~,e] = filepartsx(fn, '.nii.gz');
            this.verifyTrue(strcmp('.nii.gz', e));
        end
        function subtest_fqfileprefix(this, fqfp)
 			this.verifyTrue(ischar(fqfp));
            this.verifyFalse(isempty(fileparts(fqfp)));
            [~,~,e] = filepartsx(fqfp, '.nii.gz');
            this.verifyTrue(isempty(e));
        end
        function subtest_fqfilename(this, fqfn)
 			this.verifyTrue(ischar(fqfn));
            this.verifyFalse(isempty(fileparts(fqfn)));
            [~,~,e] = filepartsx(fqfn, '.nii.gz');
            this.verifyTrue(strcmp('.nii.gz', e));
        end
        
    end
    
    %% PRIVATE
    
    properties (Access = 'private')
        theNIfTI_
        theNIfTId_
        imcastCellResult_ = { ...
            fullfile(getenv('UNITTESTS'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/bt1_005.nii.gz') ...
            fullfile(getenv('UNITTESTS'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/bt1_005_inskull_mask.nii.gz') ...
            fullfile(getenv('UNITTESTS'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/bt1_005_inskull_mesh.nii.gz') ...
            fullfile(getenv('UNITTESTS'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/bt1_005_mask.nii.gz') ...
            fullfile(getenv('UNITTESTS'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/bt1_005_outskin_mask.nii.gz') ...
            fullfile(getenv('UNITTESTS'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/bt1_005_outskin_mesh.nii.gz') ...
            fullfile(getenv('UNITTESTS'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/bt1_005_outskull_mask.nii.gz') ...
            fullfile(getenv('UNITTESTS'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/bt1_005_outskull_mesh.nii.gz') ...
            fullfile(getenv('UNITTESTS'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/bt1_005_overlay.nii.gz') ...
            fullfile(getenv('UNITTESTS'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/bt1_005_skull_mask.nii.gz') ...
            fullfile(getenv('UNITTESTS'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/cho_f5to24_on_t1_005.nii.gz') ...
            fullfile(getenv('UNITTESTS'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/cho_f5to24_on_t1_005_gauss4p6855.nii.gz') ...
            fullfile(getenv('UNITTESTS'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/cho_f5to24_on_t1_005_gauss4p6855m.nii.gz') ...
            fullfile(getenv('UNITTESTS'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/cho_f5to24_susan5p52mm_on_t1_005.nii.gz') ...
            fullfile(getenv('UNITTESTS'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/coo_f7to26_on_t1_005.nii.gz') ...
            fullfile(getenv('UNITTESTS'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/coo_f7to26_on_t1_005_gauss4p6855.nii.gz') ...
            fullfile(getenv('UNITTESTS'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/coo_f7to26_on_t1_005_gauss4p6855m.nii.gz') ...
            fullfile(getenv('UNITTESTS'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/coo_f7to26_susan5p52mm_on_t1_005.nii.gz') ...
            fullfile(getenv('UNITTESTS'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/coo_f7to26cho_f5to24_on_t1_005.nii.gz') ...
            fullfile(getenv('UNITTESTS'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/dwi_002_on_t1_005.nii.gz') ...
            fullfile(getenv('UNITTESTS'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/epi_017_on_t1_005.nii.gz') ...
            fullfile(getenv('UNITTESTS'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/poc_on_t1_005.nii.gz') ...
            fullfile(getenv('UNITTESTS'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/poc_susan5p52mm_on_t1_005.nii.gz') ...
            fullfile(getenv('UNITTESTS'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/ptr_on_t1_005.nii.gz') ...
            fullfile(getenv('UNITTESTS'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/t1_005.nii.gz') ...
            fullfile(getenv('UNITTESTS'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/t1_005_gauss4p69mm.nii.gz') ...
            fullfile(getenv('UNITTESTS'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/t1_saveas.nii.gz') ...
            fullfile(getenv('UNITTESTS'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/t2_006.nii.gz') ...    
            fullfile(getenv('UNITTESTS'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/t2_006_on_t1_005.nii.gz') ...
            fullfile(getenv('UNITTESTS'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/t2_007.nii.gz') ...   
            fullfile(getenv('UNITTESTS'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/t2_007_on_t1_005.nii.gz')};
    end

	%  Created with Newcl by John J. Lee after newfcn by Frank Gonzalez-Morphy
 end

