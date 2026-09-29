# XeLaTeX + BibTeX; generated files stay under build/.
$pdf_mode = 5;
$out_dir = 'build';
$xelatex = 'xelatex -interaction=nonstopmode -halt-on-error %O %S';
use File::Path qw(make_path);
make_path(map { "$out_dir/$_" } qw(preface body appendix));
