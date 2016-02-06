classdef Test_CasterStrategy < mlfourd_unittest.Test_mlfourd
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
 		testObj
 		casterStrat
        dwi2_fqfn = fullfile(getenv('MLUNIT_TEST_PATH'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/adc_default_on_t1_default.nii.gz')
        dwi3_fqfn = fullfile(getenv('MLUNIT_TEST_PATH'), 'cvl/np755/mm01-020_p7377_2009feb5/fsl/dwi_002_on_t1_005_shadowreg_dwi_003.nii.gz')
 	end

	methods (Test) 		
 		function test_castto(this) 
 			import mlcaster.*; 
            this.verifyClass(this.casterStrat.castto('fqfilename'),       'char');
            this.verifyClass(this.casterStrat.castto('fqfileprefix'),     'char');            
            this.verifyClass(this.casterStrat.castto('filename'),         'char');
            this.verifyClass(this.casterStrat.castto('fileprefix'),       'char');
            this.verifyClass(this.casterStrat.castto('NIfTI'),            'mlfourd.NIfTI');
            this.verifyClass(this.casterStrat.castto('NIfTId'),           'mlfourd.NIfTId');
        end 
        function test_casttoChar(this)
            caster = mlcaster.CasterStrategy.newStrategy(fullfile(this.fslPath, 't1_default.nii.gz'));
            cobj = caster.castto('fileprefix');
            this.verifyEqual('t1_default', cobj);
            cobj = caster.castto('fqfilename');
            this.verifyTrue(lexist(cobj, 'file'));
        end
        function test_casttoImage(this)            
            import mlfourd.*;
            fqfn   = fullfile(this.fslPath, 'dwi_default.nii.gz');
            caster = mlcaster.CasterStrategy.newStrategy(fqfn);
            cobj   = caster.castto('fqfilename');
                     this.verifyEqual(fqfn, cobj);
            cobj   = caster.castto('mlfourd.NIfTI');
                     this.verifyEqual(NIfTI.load(fqfn), cobj);
            cobj   = caster.castto('mlfourd.NIfTId');
            cobj_  = NIfTId.load(fqfn);
                     this.verifyEqual(double(cobj_.img), double(cobj.img)); % diff in datatype which can't be assigned
        end
 	end

 	methods (TestClassSetup)
 		function setupCasterStrategy(this)
            cd(this.fslPath); 
            this.casterStrat = mlcaster.CasterStrategy.newStrategy(this.t1_fqfn);
            mlbash(sprintf('rm %s', fullfile(this.fslPath, '*_shadowreg_*')));
 		end
 	end

 	methods (TestMethodSetup)
 	end

	%  Created with Newcl by John J. Lee after newfcn by Frank Gonzalez-Morphy
 end

