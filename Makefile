package := flutter_app
file := test/coverage_helper_test.dart

generate_coverage_index_file:
	@echo "// Helper file to make coverage work for all dart files\n" > ${file}
	@echo "// ignore_for_file: unused_import" >> ${file}
	@echo "// https://github.com/flutter/flutter/issues/27997#issuecomment-926524213" >> ${file}
	@echo "// ignore_for_file: directives_ordering" >> ${file}
	@find lib -not -name '*.g.dart' -and -not -name '**/gen/*.dart' -and -not -name '**/generated/*.dart' -and -not -name '*.gen.dart'  -and -not -name 'generated_plugin_registrant.dart' -and -name '*.dart'| cut -c4- | awk -v package=${package} '{printf "import '\''package:%s%s'\'';\n", package, $$1}' >> ${file}
	@echo "void main(){}" >> ${file}
	$(info generated ${file})


merge_and_clean_coverage:
	$(info merging and cleaning coverage files from generated files data)
	@lcov -a coverage/goldens.lcov.info -a coverage/unit_tests.lcov.info -o coverage/lcov.info
	@lcov --remove coverage/lcov.info 'lib/*/*.g.dart' 'lib/generated_assets/*.dart' 'lib/*/*.gen.dart' 'lib/generated_plugin_registrant.dart' -o coverage/lcov.info

extract_coverage_percentage:
	export coverage_percent=`lcov --summary coverage/main.lcov.info | sed -n '3p' | sed -r 's/(.+):(.+)(\%.+)/\2/' | cat`
