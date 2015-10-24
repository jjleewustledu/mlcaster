classdef Test_CasterStrategy < matlab.unittest.TestCase
	%% TEST_CASTERSTRATEGY 

	%  Usage:  >> results = run(mlcaster_unittest.Test_CasterStrategy)
 	%          >> result  = run(mlcaster_unittest.Test_CasterStrategy, 'test_dt')
 	%  See also:  file:///Applications/Developer/MATLAB_R2014b.app/help/matlab/matlab-unit-test-framework.html

	%  $Revision$
 	%  was created 20-Oct-2015 01:51:39
 	%  by jjlee,
 	%  last modified $LastChangedDate$
 	%  and checked into repository /Users/jjlee/Local/src/mlcvl/mlcaster/test/+mlcaster_unittest.
 	%% It was developed on Matlab 8.5.0.197613 (R2015a) for MACI64.
 	

	properties
 		registry
 		testObj
 		casterStrat
        dwi2_fqfn = fullfile(getenv('MLUNIT_TEST_PATH'), 'np755/mm01-020_p7377_2009feb5/fsl/adc_default_on_t1_default.nii.gz')
        dwi3_fqfn = fullfile(getenv('MLUNIT_TEST_PATH'), 'np755/mm01-020_p7377_2009feb5/fsl/dwi_002_on_t1_005_shadowreg_dwi_003.nii.gz')
 	end

	methods (Test) 		
 		function test_castto(this) 
 			import mlcaster.*; 
            this.verifyClass(this.casterStrat.castto('fqfilename'),       'char');
            this.verifyClass(this.casterStrat.castto('fqfileprefix'),     'char');            
            this.verifyClass(this.casterStrat.castto('filename'),         'char');
            this.verifyClass(this.casterStrat.castto('fileprefix'),       'char');
            this.verifyClass(this.casterStrat.castto('NIfTI'),            'mlfourd.NIfTIInterface');
            this.verifyClass(this.casterStrat.castto('ImagingComponent'), 'mlfourd.ImagingComponent');
        end 
        function test_casttoCharCell(this)
            caster = mlcaster.CasterStrategy.newStrategy(fullfile(this.fslPath, '*t1*.nii.gz'));
            cobj = caster.castto('fileprefix');
            this.verifyGreaterThanOrEqual(length(cobj), 80);
            this.verifyEqual('adc_default_on_bt1_default_restore', cobj{1});
            cobj = caster.castto('fqfilename');
            this.verifyGreaterThanOrEqual(length(cobj), 79);
            this.verifyTrue(lexist(cobj{1}, 'file'));
        end
        function test_casttoImageCell(this)            
            import mlfourd.*;
            caster = mlcaster.CasterStrategy.newStrategy(fullfile(this.fslPath, 'dwi*t1*.nii.gz'));
            cobj   = caster.castto('fqfilename');
                     this.verifyEqual(this.dwi2_fqfn, cobj{1});
            cobj   = caster.castto('mlfourd.NIfTI');
                     this.verifyEqual(NIfTI.load(this.dwi2_fqfn), cobj{1});
            cobj   = caster.castto('mlfourd.ImagingComponent');
            imser  = ImagingSeries.load(this.dwi2_fqfn);
                     this.verifyEqual(single(imser.img), single(cobj{1}.img));
        end
 	end

 	methods (TestClassSetup)
 		function setupCasterStrategy(this)
            this.casterStrat = mlcaster.CasterStrategy.newStrategy(this.t1_fqfn);
            mlbash(sprintf('rm %s', fullfile(this.fslPath, '*_shadowreg_*')));
 		end
 	end

 	methods (TestMethodSetup)
 	end

	%  Created with Newcl by John J. Lee after newfcn by Frank Gonzalez-Morphy
 end

