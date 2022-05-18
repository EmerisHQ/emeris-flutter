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