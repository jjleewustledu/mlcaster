classdef Test_CasterStrategy < MyTestCase
	%% TEST_CASTERSTRATEGY 
	%  Usage:  >> runtests tests_dir 
	%          >> runtests mlcaster.Test_CasterStrategy % in . or the matlab path
	%          >> runtests mlcaster.Test_CasterStrategy:test_nameoffunc
	%          >> runtests(mlcaster.Test_CasterStrategy, Test_Class2, Test_Class3, ...)
	%  See also:  package xunit

	%  $Revision: 2640 $
 	%  was created $Date: 2013-09-21 17:58:17 -0500 (Sat, 21 Sep 2013) $
 	%  by $Author: jjlee $, 
 	%  last modified $LastChangedDate: 2013-09-21 17:58:17 -0500 (Sat, 21 Sep 2013) $
 	%  and checked into repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mlcaster/test/+mlcaster_xunit/trunk/Test_CasterStrategy.m $, 
 	%  developed on Matlab 8.1.0.604 (R2013a)
 	%  $Id: Test_CasterStrategy.m 2640 2013-09-21 22:58:17Z jjlee $
 	%  N.B. classdef (Sealed, Hidden, InferiorClasses = {?class1,?class2}, ConstructOnLoad)

	properties
 		casterStrat
        dwi2_fqfn = fullfile(getenv('MLUNIT_TEST_PATH'), 'np755/mm01-020_p7377_2009feb5/fsl/adc_default_on_t1_default.nii.gz')
        dwi3_fqfn = fullfile(getenv('MLUNIT_TEST_PATH'), 'np755/mm01-020_p7377_2009feb5/fsl/dwi_002_on_t1_005_shadowreg_dwi_003.nii.gz')
 	end

	methods 
 		% N.B. (Static, Abstract, Access='', Hidden, Sealed) 

 		function test_castto(this) 
 			import mlcaster.*; 
            assert(ischar(this.casterStrat.castto('fqfilename')));
            assert(ischar(this.casterStrat.castto('fqfileprefix')));            
            assert(ischar(this.casterStrat.castto('filename')));
            assert(ischar(this.casterStrat.castto('fileprefix')));
            assert(isa(this.casterStrat.castto('NIfTI'), 'mlfourd.NIfTIInterface'));
            assert(isa(this.casterStrat.castto('ImagingComponent'), 'mlfourd.ImagingComponent'));
        end 
        function test_casttoCharCell(this)
            caster = mlcaster.CasterStrategy.newStrategy(fullfile(this.fslPath, '*t1*.nii.gz'));
            cobj = caster.castto('fileprefix');
            assertTrue(length(cobj) >= 80);
            assertEqual('adc_default_on_bt1_default_restore', cobj{1});
            cobj = caster.castto('fqfilename');
            assertTrue(length(cobj) > 79);
            assertTrue(lexist(cobj{1}, 'file'));
        end
        function test_casttoImageCell(this)            
            import mlfourd.*;
            caster = mlcaster.CasterStrategy.newStrategy(fullfile(this.fslPath, 'dwi*t1*.nii.gz'));
            cobj   = caster.castto('fqfilename');
                     assertEqual(this.dwi2_fqfn, cobj{1});
            cobj   = caster.castto('mlfourd.NIfTI');
                     this.assertObjectsEqual(NIfTI.load(this.dwi2_fqfn), cobj{1});
            cobj   = caster.castto('mlfourd.ImagingComponent');
            imser  = ImagingSeries.load(this.dwi2_fqfn);
                     assertElementsAlmostEqual(single(imser.img), single(cobj{1}.img));
        end
 		function this = Test_CasterStrategy(varargin) 
 			this = this@MyTestCase(varargin{:}); 
            this.casterStrat = mlcaster.CasterStrategy.newStrategy(this.t1_fqfn);
            mlbash(sprintf('rm %s', fullfile(this.fslPath, '*_shadowreg_*')));
        end % ctor 
 	end 

	%  Created with Newcl by John J. Lee after newfcn by Frank Gonzalez-Morphy 
end

