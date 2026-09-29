# 自动生成封面

编译 `root.tex` 会先调用 `\jnmakecover` 生成封面，再生成摘要及正文。无需另行导出 `cover.pdf`。

## 填写位置

编辑 `setup/settings.tex`：

- `\title{中文论文题目}`：一般不超过 25 字，采用黑体小二号；需要指定换行时可用 `\\`。
- `\author{研究生姓名}`。
- `\jncoverinfo{...}` 中填写英文题目、分类号、学科或专业类别、研究方向、导师姓名及职称、学位授予年月。
- `degree-type = academic` 表示学术学位；`professional` 表示专业学位。专业学位额外显示 `industry-supervisor`，即行业导师。
- `secret`：非涉密论文保持空白。
- `group-members`：没有指导小组成员时可留空。
- `award-date`：填写实际学位授予年月，例如 `二〇二六年六月`，不会随编译日期变化。

硕士与博士由 `root.tex` 的 `\documentclass[master]{jnthesis}` 或 `\documentclass[doctor]{jnthesis}` 决定。封面名称随之切换。`nodegree` 为旧版毕业论文兼容选项，不属于附件1的四种学位封面。

当前设置保留待填写项，不代表已填入真实身份或学科信息。学校代码固定为 10295，地址固定为无锡市蠡湖大道 1800 号。

## 排版及资源

封面依据官方 Word 附件1的四种样式实现：硕士/博士 × 学术/专业学位。中文题目为黑体小二号，英文题目为 Times New Roman 三号，顶部分类信息用仿宋四号。封面保持 A4 和四边 2.5 cm；自然换行会随实际题目长度变化。

`assets/jnu-wordmark.jpeg` 原样提取自用户提供的 `参考/Word版附件/附件1. 学位论文封面及书脊样例.docx` 中 `word/media/image1.jpeg`，用于复用附件中的江南大学校名字样。

除正文已有的 SimSun、SimHei、Times New Roman 外，封面还需要 FangSong 仿宋。查找顺序为用户自备 `fonts/simfang.ttf`、macOS Microsoft Word 自带的 `Fangsong.ttf`、系统 FangSong。字体文件不随项目分发。

封面实现位于 `jncover.sty`。标题、信息区可自动换行；过长的字段应自行精简，编译后检查封面仍为一页。

## 页码和单面印刷

封面不显示页眉和页码，也不计入摘要的罗马数字页码。当前双面文档会自动保留一个空白封面背面，摘要从右页和罗马数字 I 开始，正文依然从阿拉伯数字 1 开始。这个空白背面是单面封面与双面内文之间的正常衔接。

声明、使用授权说明和答辩委员会页现已自动生成并纳入同一份 `build/root.pdf`，名单填写和整本打印说明见 [完整论文打印说明](printing.md)。书脊仍应按实际装订厚度另行制作。
