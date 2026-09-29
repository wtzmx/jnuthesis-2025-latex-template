# 江南大学研究生学位论文 LaTeX 模板

适配《江南大学研究生学位论文要求及格式规范（2025年修订）》。当前版本 **0.4.0**，支持硕士、博士的学术学位与专业学位封面。此派生版本由 [wtzmx](https://github.com/wtzmx) 维护。

一次编译生成包含**封面、原创性声明及使用授权说明、答辩委员会名单、摘要、目录和正文**的完整 PDF。学校通知及五份 Word 附件保存在 [`参考/`](参考/)，随项目和发布包一起提供。

## 开始使用

需要 TeX Live / MacTeX / MiKTeX 中的 **XeLaTeX、BibTeX、latexmk**，以及宋体、黑体、仿宋、楷体、Times New Roman。macOS 可读取已安装 Microsoft Word 自带的中文字体；其他环境的准备方式见 [字体说明](fonts/README.md)。字体文件不随发布包提供。

1. 在 [`setup/settings.tex`](setup/settings.tex) 填写题目、作者、专业、导师及封面信息。
2. 在 [`setup/committee.tex`](setup/committee.tex) 填写答辩委员会与日期。
3. 编辑 `preface/`、`body/`、`appendix/` 中的内容，在 `main.tex` 管理章节。
4. 在项目根目录执行：

```sh
latexmk root.tex
```

最终文件为 **`build/root.pdf`**，所有中间文件也放在 `build/`，不会散落到章节目录。发布 ZIP 中另附 `example.pdf` 供预览，内容仍是待填写的模板。

仅修改正文后再次运行同一命令即可。清除中间文件、保留 PDF：

```sh
latexmk -c root.tex
```

TeXShop、TeXstudio 或 VS Code 可打开 `root.tex`；建议选择 latexmk / XeLaTeX 构建方式。直接执行 `xelatex root.tex` 仍可使用，但会在源目录产生输出，且需要自行运行 BibTeX 和重复编译。

### Overleaf

上传发布 ZIP 后选择 `root.tex` 和 **XeLaTeX**。需按 [字体说明](fonts/README.md) 自备字体；如平台不采用本项目的输出目录设置，以平台生成的 PDF 为准。`参考/` 中的 PDF 和 Word 文件用于查阅，不参与编译。

## 配置与目录

| 路径 | 用途 |
| --- | --- |
| `root.tex` / `main.tex` | 论文结构 / 正文章节列表 |
| `setup/settings.tex` | 封面信息与学术/专业学位选择 |
| `setup/committee.tex` | 委员会名单和答辩日期 |
| `setup/packages.tex` / `setup/userdefs.tex` | 附加宏包 / 自定义命令 |
| `setup/fonts.tex` / `fonts/` | 字体配置 / 自备字体放置位置 |
| `preface/` | 声明、中文摘要、英文摘要 |
| `body/` / `appendix/` | 正文 / 致谢与成果清单 |
| `figures/` / `references.bib` | 插图 / 文献数据库 |
| `jnthesis.cls` / `jn*.sty` / `jn.bst` | 文档类、前置页和参考文献样式 |
| `参考/` | 学校通知 PDF 及五份官方 Word 附件 |
| `docs/` | 封面、格式依据、打印和发布说明 |
| `scripts/release.py` | 本地构建发布包，不上传、不创建远程发布 |
| `build/` / `dist/` | 本地编译 / 发布产物，均不加入 Git |

硕士和博士在 `root.tex` 中选择：

```tex
\documentclass[master]{jnthesis} % 博士改为 doctor
```

学术和专业学位在 `setup/settings.tex` 中选择 `degree-type = academic` 或 `professional`。专业学位封面自动增加行业导师栏。

## 填写与打印

- [封面说明](docs/cover.md)
- [完整论文填写与打印](docs/printing.md)
- [2025 格式依据及附件差异](docs/format-2025.md)

整份 PDF 按 **A4、100%、双面长边翻转**打印，并保留空白页，确保封面、声明页和委员会页单面印刷。签名、日期按学校要求亲笔填写。正文和个人信息仍需自行完成；书脊按装订厚度另行制作。

## 发布维护

```sh
python3 scripts/release.py
```

脚本先编译，再生成 `dist/jnuthesis-2025-v0.4.0.zip` 及 SHA-256 校验文件。ZIP 包含源码、使用文档、完整参考附件和示例 PDF；排除字体文件、Git 元数据、编译缓存及本地发布目录。详见 [发布说明](docs/releasing.md) 和 [更新记录](CHANGELOG.md)。

## 来源与许可

本仓库 Fork 自 [lou-kaiqiang/jnuthesis-2025-latex-template](https://github.com/lou-kaiqiang/jnuthesis-2025-latex-template)，上游基于 Bo Zhuang 的 [jnthesis](https://gitee.com/zhuangbo/jnthesis) 修改。本项目并非学校官方维护的模板。格式依据见随附通知和[研究生院说明](https://gs.jiangnan.edu.cn/info/1057/2812.htm)。

项目主许可见 [LICENSE.txt](LICENSE.txt)。`jn.bst` 的 LPPL 声明、学校附件及校名字样的来源分别见 [第三方来源说明](THIRD_PARTY_NOTICES.md)，主许可不覆盖这些独立声明。
