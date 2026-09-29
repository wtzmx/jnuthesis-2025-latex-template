#!/usr/bin/env python3
"""Build and package the template, reference attachments and example PDF."""
from pathlib import Path
import hashlib
import re
import subprocess
import zipfile

ROOT = Path(__file__).resolve().parents[1]
ROOT_FILES = (
    '.gitignore', '.latexmkrc', 'VERSION', 'LICENSE.txt', 'THIRD_PARTY_NOTICES.md',
    'README.md', 'CHANGELOG.md', 'root.tex', 'main.tex', 'references.bib',
    'jnthesis.cls', 'jncover.sty', 'jnfrontpages.sty', 'jn.bst',
)
# Per-directory allowlist: no commercial fonts, auxiliary files or local exports.
DIRECTORIES = {
    'setup': {'.tex'}, 'body': {'.tex'}, 'preface': {'.tex'}, 'appendix': {'.tex'},
    'assets': {'.jpeg', '.png', '.svg'}, 'figures': {'.png', '.jpg', '.jpeg', '.pdf', '.svg'},
    'fonts': {'.md'}, 'docs': {'.md'},
    'scripts': {'.py'}, '参考': {'.pdf', '.docx', '.md'},
}


def main():
    version = (ROOT / 'VERSION').read_text().strip()
    if not re.fullmatch(r'\d+\.\d+\.\d+', version):
        raise SystemExit('VERSION must contain a semantic version, such as 0.4.0')
    subprocess.run(['latexmk', 'root.tex'], cwd=ROOT, check=True)
    pdf = ROOT / 'build/root.pdf'
    if not pdf.is_file() or not pdf.read_bytes().startswith(b'%PDF-'):
        raise SystemExit('Build did not produce build/root.pdf')

    files = {name: (ROOT / name).read_bytes() for name in ROOT_FILES}
    for folder, suffixes in DIRECTORIES.items():
        for path in sorted((ROOT / folder).rglob('*')):
            if path.is_file() and not path.is_symlink() and (
                path.suffix.lower() in suffixes or path.name == '.gitkeep'
            ):
                files[path.relative_to(ROOT).as_posix()] = path.read_bytes()
    references = [name for name in files if name.startswith('参考/')]
    if sum(name.endswith('.docx') for name in references) < 5 or not any(
        name.endswith('.pdf') for name in references
    ):
        raise SystemExit('Missing school notice PDF or Word reference attachments')
    files['example.pdf'] = pdf.read_bytes()
    files['MANIFEST.sha256'] = ''.join(
        f'{hashlib.sha256(data).hexdigest()}  {name}\n'
        for name, data in sorted(files.items())
    ).encode()

    dist = ROOT / 'dist'
    dist.mkdir(exist_ok=True)
    name = f'jnuthesis-2025-v{version}'
    archive = dist / f'{name}.zip'
    temporary = archive.with_suffix('.zip.tmp')
    with zipfile.ZipFile(temporary, 'w', zipfile.ZIP_DEFLATED) as output:
        for path, data in sorted(files.items()):
            info = zipfile.ZipInfo(f'{name}/{path}', date_time=(2026, 1, 1, 0, 0, 0))
            info.compress_type = zipfile.ZIP_DEFLATED
            info.external_attr = 0o100644 << 16
            output.writestr(info, data)
    with zipfile.ZipFile(temporary) as output:
        if output.testzip() is not None:
            raise SystemExit('Archive integrity check failed')
    temporary.replace(archive)
    checksum = hashlib.sha256(archive.read_bytes()).hexdigest()
    archive.with_suffix('.zip.sha256').write_text(f'{checksum}  {archive.name}\n')
    print(f'Created {archive} ({len(files)} files, including references and example.pdf)')


if __name__ == '__main__':
    main()
