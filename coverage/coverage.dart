// ignore_for_file: avoid_print
import 'dart:io';

const mainLcov = 'coverage/main.lcov.info';
const prLcov = 'coverage/lcov.info';

Future<void> main(List<String> args) async {
  switch (args[0]) {
    case 'main_branch_percentage':
      print((await _calculateCoveragePercentage(mainLcov)).toStringAsFixed(2));
      return;
    case 'pr_branch_percentage':
      print((await _calculateCoveragePercentage(prLcov)).toStringAsFixed(2));
      return;
    case 'check_percentage':
    default:
      await _checkCoveragePercentage();
      return;
  }
}

Future<void> _checkCoveragePercentage() async {
  final mainPercentage = await _calculateCoveragePercentage(mainLcov);

  final prPercentage = await _calculateCoveragePercentage(prLcov);
  print(
    "\n\nmain branch' test coverage percentage: ${mainPercentage.toStringAsFixed(2)}\n"
    "pr branch' test coverage percentage:  ${prPercentage.toStringAsFixed(2)}\n\n",
  );
  if (prPercentage < mainPercentage) {
    throw '\n\n!!ERROR!!\n\nThe test coverage percentage in this pull request is lower than the one on the target branch.\n\n';
  }
}

Future<double> _calculateCoveragePercentage(String lcovFile) async {
  final lines = await File(lcovFile).readAsLines();
  final coverage = lines.fold<List<int>>([0, 0], (data, line) {
    var testedLines = data[0];
    var totalLines = data[1];
    if (line.startsWith('DA:')) {
      totalLines++;
      if (!line.endsWith(',0')) {
        testedLines++;
      }
    }
    return [testedLines, totalLines];
  });
  final testedLines = coverage[0];
  final totalLines = coverage[1];
  return testedLines / totalLines * 100;
}
