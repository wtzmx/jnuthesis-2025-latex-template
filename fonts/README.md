# 字体准备

正式模板使用宋体 SimSun、黑体 SimHei、仿宋 FangSong、楷体 KaiTi，以及 Times New Roman。不会静默替换成 Fandol。

Windows 可使用系统或办公软件提供的字体；macOS 可直接读取 `/Applications/Microsoft Word.app/Contents/Resources/DFonts/` 中的中文字体，Times New Roman 从系统读取。

在其他电脑或 Overleaf 上，可在使用许可允许的情况下自行准备以下文件，放入本目录：

| 文件名 | 用途 |
| --- | --- |
| `simsun.ttc` | 宋体正文及标题 |
| `simhei.ttf` | 黑体标题 |
| `simfang.ttf` | 封面分类信息的仿宋 |
| `simkai.ttf` | 声明页楷体；也接受 `kaiti_gb2312.ttf` |
| `times.ttf` | Times New Roman 常规 |
| `timesbd.ttf` | Times New Roman 粗体 |
| `timesi.ttf` | Times New Roman 斜体 |
| `timesbi.ttf` | Times New Roman 粗斜体 |

如系统已经能识别字体，不必放入这些文件。若提供 `times.ttf`，其余三个 Times 字款也应一并提供。不同来源的文件名可能不同，可在本地重命名为表中名称。

字体文件已被 `.gitignore` 和发布脚本排除，发布包只带此说明。中文字体解析在 `setup/fonts.tex`、`jncover.sty`、`jnfrontpages.sty` 中；宋体合成加粗设置为 2.17。
