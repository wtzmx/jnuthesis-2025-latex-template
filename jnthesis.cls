% !Mode:: "TeX:UTF-8"
% !TeX encoding = UTF-8 Unicode
% !TeX program = xelatex

%% LaTeX2e class for student thesis of Jiangnan University
%% jnthesis.cls
%%
%% Bo Zhuang
%% bozhuang@jiangnan.edu.cn
%% 
%% Version 0.1, 2019/04/21
%% 
%% Yu Wang
%% wangyu@stu.jiangnan.edu.cn
%% 
%% Version 0.3, 2026/06/22



\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jnthesis}[2026/09/29 v0.4.0 Thesis class of Jiangnan University]

\LoadClass[UTF8,zihao=-4,scheme=chinese,punct,twoside,a4paper,openany,fontset=none]{ctexbook}

\RequirePackage{hyperref} % 超链接
\RequirePackage{graphicx} % 插图
\RequirePackage{subfig}   % 子图
\RequirePackage{color}    % 颜色
\RequirePackage{enumerate}% 列表
\RequirePackage{enumitem}
\RequirePackage{amsmath}  % 数学公式 ([fleqn] 左对齐)
\RequirePackage{amssymb, amsfonts, mathrsfs, mathtools} % 数学字体符号
\RequirePackage[hyperref, thmmarks, amsmath]{ntheorem}  % 定理
% \RequirePackage{algorithm2e,algpseudocode} % 算法伪代码
\RequirePackage[ruled,linesnumbered,inoutnumbered,commentsnumbered,nofillcomment]{algorithm2e} % 算法伪代码
\RequirePackage{listings}  % 程序代码
\RequirePackage[square, super, comma, sort&compress]{natbib}   % 参考文献
\RequirePackage[final]{pdfpages} % 插入封面 PDF 文件
\RequirePackage{multirow}
\RequirePackage{float}

% mathrsfs 的设计尺寸按区间缩放，避免中文字号触发尺寸替换警告。
\DeclareFontFamily{U}{rsfs}{\skewchar\font127 }
\DeclareFontShape{U}{rsfs}{m}{n}{<-6.5> rsfs5 <6.5-8> rsfs7 <8-> rsfs10}{}

\RequirePackage{fontspec}  % 字体
\RequirePackage{setspace}  % 行距
\RequirePackage{emptypage} % 清空空白页
\RequirePackage{fancyhdr}  % 页眉页脚
% 标题统一由 ctex 管理，避免 titlesec 覆盖章序和间距。
\RequirePackage{titletoc}  % 目录格式
\RequirePackage{ifthen}    % If-Then

% nice tables
\RequirePackage{booktabs}
\RequirePackage{longtable}
\RequirePackage{array}
\RequirePackage{hhline}
\RequirePackage{threeparttable}
\RequirePackage{siunitx}          % 国际单位

%% 标准文档类结构名重定义
\renewcommand{\partname}{第\chinese{part}部分}
\ctexset{chapter={number=\arabic{chapter},name={第,章}}}
\renewcommand{\contentsname}{目\hspace{2em}录}
\renewcommand{\figurename}{图}
\renewcommand{\tablename}{表}
\renewcommand{\bibname}{参考文献}
\renewcommand{\abstractname}{摘\hspace{2em}要}

%% 毕业与学位
\def\jnmaster{硕士}
\def\jndoctor{博士}
\def\thedegree{\jndoctor} % 学位 (默认为博士)
\def\jndegree{学位}
% 若文档参数中包含 master 则设置为硕士学位
\DeclareOption{master}{\def\thedegree{\jnmaster}}
\DeclareOption{doctor}{\def\thedegree{\jndoctor}}
\DeclareOption{nodegree}{\def\jndegree{毕业}} % 毕业论文, 不申请学位
\ProcessOptions\relax

%% 正式字体配置：正文与显式字体族必须同步，禁止静默回退。
\input{setup/fonts.tex}
\RequirePackage{jncover}
\RequirePackage{jnfrontpages}

% 链接样式
\hypersetup{
  colorlinks=true,
  linkcolor=blue,
  citecolor=blue,
}

% 引用样式
\providecommand{\citeit}[2][]{\unskip{\setcitestyle{numbers,square}\cite[#1]{#2}}}

%% 通知第三、四部分：A4，四边 2.5 cm；页眉、页脚在版心外。
\RequirePackage[a4paper,margin=2.5cm,headheight=15pt,
  headsep=0.45cm,footskip=0.75cm]{geometry}

% 1.25 倍行距；不再用视觉估计的 1.35 倍。
\setstretch{1.25}
\setlength{\parindent}{2\ccwd}
\setlength{\parskip}{0pt}
\setcounter{tocdepth}{2}
\setcounter{secnumdepth}{3}

% Word 附件的“一行”段距为 312 twips = 15.6 bp。
% 半行段距相应为 7.8 bp；bp 与 Word 的磅同为 1/72 英寸。
\ctexset{
  chapter={format=\normalfont\centering\heiti\zihao{3},
    beforeskip=15.6bp,afterskip=15.6bp,afterindent=true,pagestyle=fancy},
  section={format=\normalfont\songti\zihao{4}\bfseries,
    beforeskip=7.8bp,afterskip=7.8bp,afterindent=true},
  subsection={format=\normalfont\songti\zihao{-4}\bfseries,
    beforeskip=7.8bp,afterskip=7.8bp,afterindent=true},
  subsubsection={format=\normalfont\songti\zihao{-4}\bfseries,
    beforeskip=7.8bp,afterskip=7.8bp,afterindent=true}
}

%% 目录格式
% 一级目录：章
\titlecontents{chapter}[0pt]
{\songti\zihao{-4}\baselineskip=20bp}%
{\thecontentslabel\quad}{}%
{\hspace{.5em}\titlerule*[4pt]{$\cdot$}\contentspage}

% 二级目录：节（左缩进2字符）
\titlecontents{section}[2em]
{\songti\zihao{-4}\baselineskip=20bp}%
{\thecontentslabel\quad}{}%
{\hspace{.5em}\titlerule*[4pt]{$\cdot$}\contentspage}

% 三级目录：小节（左缩进4字符）
\titlecontents{subsection}[4em]
{\songti\zihao{-4}\baselineskip=20bp}%
{\thecontentslabel\quad}{}%
{\hspace{.5em}\titlerule*[4pt]{$\cdot$}\contentspage}

% 前置页与正文均按奇偶页设置页眉；所有页码五号居中。
\newcommand{\samplepagestyle}[1]{%
  \pagestyle{fancy}%
  \fancyhf{}%
  \fancyhead[CO]{\normalfont\songti\zihao{5}#1}%
  \fancyhead[CE]{\normalfont\songti\zihao{5}江南大学\thedegree\jndegree 论文}%
  \fancyfoot[C]{\normalfont\rmfamily\zihao{5}\thepage}%
}
\newcommand{\jnfrontmatter}{%
  \frontmatter
  \pagenumbering{Roman}%
  \samplepagestyle{}%
}
\newcommand{\jnabstract}[1][zh]{%
  \clearpage
  \ifthenelse{\equal{#1}{en}}{%
    \samplepagestyle{Abstract}%
    \chapter*{\normalfont\rmfamily\bfseries Abstract}%
    \addcontentsline{toc}{chapter}{Abstract}%
  }{%
    \samplepagestyle{摘要}%
    \chapter*{\abstractname}%
    \addcontentsline{toc}{chapter}{摘\hspace{2em}要}%
  }%
  \normalsize\songti
}
\newenvironment{jnkeywords}[1][zh]{%
  \par\indent
  \ifthenelse{\equal{#1}{en}}{%
    \def\sep{\unskip;\space}%
    {\bfseries Keywords:}\space
  }{%
    \def\sep{\unskip；\ignorespaces}%
    {\songti\bfseries 关键词：}%
  }\ignorespaces
}{\par}
\newcommand{\sep}{\unskip；\ignorespaces}
\newcommand{\jncontents}{%
  \clearpage
  \samplepagestyle{目录}%
  \tableofcontents
}
\newcommand{\jnmainmatter}{%
  \mainmatter % 仅正文起始处补齐到右页；后续章使用 openany。
  \samplepagestyle{\leftmark}%
  \normalsize\songti
}
\newcommand{\ackname}{致谢}
\newcommand{\jnacknowledgements}{%
  \clearpage
  \samplepagestyle{\ackname}%
  \chapter*{致\hspace{2em}谢}%
  \addcontentsline{toc}{chapter}{致\hspace{2em}谢}%
  \normalsize\songti
}

%%% 参考文献样式
\def\bstfile{jn}                    % 默认的 bst 文件名
\newcommand{\setbstfile}[1]{\def\bstfile{#1}}   % 设置 bst 文件命令
\def\bibfiles{references}           % 默认的 bib 文件名
\newcommand{\setbibfiles}[1]{\def\bibfiles{#1}} % 设置 bib 文件命令

% 将五号字限制在文献表内部，避免字号泄漏到致谢与成果清单。
\setlength{\bibsep}{0pt}
\renewcommand{\bibfont}{\setstretch{1.25}\normalfont\songti\zihao{5}}
\renewcommand{\bibsection}{%
  \chapter*{\bibname}%
  \addcontentsline{toc}{chapter}{\bibname}%
}
\newcommand{\jnreferences}{%
  \clearpage
  \samplepagestyle{\bibname}%
  \bibliographystyle{\bstfile}%
  \bibliography{\bibfiles}%
  \normalsize\songti
}
\renewcommand\@biblabel[1]{[#1]\hfill\hspace{-0.25em}}  % 参考文献标号左对齐

% 发表论文
\newcommand{\jnpublications}{
  \clearpage
  \samplepagestyle{\songti\zihao{5}攻读学位期间取得的学术成果清单}
  \chapter*{攻读学位期间取得的学术成果清单}
  \normalsize\songti
  \addcontentsline{toc}{chapter}{攻读学位期间取得的学术成果清单}
}

%% 图和表格标题
\renewcommand {\thetable} {\thechapter{}-\arabic{table}}
\renewcommand {\thefigure} {\thechapter{}-\arabic{figure}}
\RequirePackage{caption}
\DeclareCaptionFont{jncaption}{\setstretch{1.25}\normalfont\songti\zihao{5}}
\captionsetup{labelsep=quad,font=jncaption,justification=centering}
\captionsetup[table]{position=top}
\captionsetup[figure]{position=bottom}
\RequirePackage{bicaption} % 双标题
\captionsetup[figure][bi-first]{name=图}
\captionsetup[figure][bi-second]{name=Figure}
\captionsetup[table][bi-first]{name=表}
\captionsetup[table][bi-second]{name=Table}

% 调整图表间距格式
\raggedbottom % 解决重新编译后页面分布不均
\AtBeginEnvironment{tabularx}{\songti\zihao{5}}
\AtBeginEnvironment{tabular}{\songti\zihao{5}}
\AtBeginEnvironment{longtable}{\songti\zihao{5}}
\captionsetup[figure]{aboveskip=9pt, skip=9pt} % 只调整图片标题的间距

% 三线表线的粗细
\setlength{\heavyrulewidth}{1.5pt} % 上横线和下横线的粗细
\setlength{\lightrulewidth}{0.75pt} % 中间横线的粗细

% 定理环境
\theoremheaderfont{\heiti}
\theorembodyfont{\songti}
\theoremnumbering{arabic}
\theoremseparator{\hspace{0.5em}}
\theorempreskip{5pt}
\theorempostskip{5pt}
\theoremsymbol{}

\theoremstyle{plain}
\newtheorem{theorem}{\hspace{2em}定理}[chapter]
\newtheorem{lemma}{\hspace{2em}引理}[chapter]
\newtheorem{proposition}{\hspace{2em}命题}[chapter]
\newtheorem{assumption}{\hspace{2em}假设}[chapter]
\newtheorem{corollary}{\hspace{2em}推论}[chapter]
\newtheorem{property}{\hspace{2em}性质}[chapter]
\newtheorem{axiom}{\hspace{2em}公理}[chapter]

% \theoremstyle{definition}
\newtheorem{definition}{\hspace{2em}定义}[chapter]
\newtheorem{example}{\hspace{2em}例}[chapter]

% \theoremstyle{remark}
\newtheorem{remark}{\hspace{2em}注}[chapter]

\theoremsymbol{$\square$}
\newtheorem*{proof}{\hspace{2em}证明}

% 公式格式
\allowdisplaybreaks[4] % 允许 align 公式跨页

% 伪代码使用中文
\renewcommand{\algorithmcfname}{算法}
\SetKwInOut{KwIn}{输入}
\SetKwInOut{KwOut}{输出}

% 可选附录放在参考文献之后、致谢之前。
\newcommand{\jnappendix}{%
  \appendix
  \ctexset{chapter={name={附\hspace{2em}录\space,},number=\Alph{chapter}}}%
  \renewcommand{\theequation}{\thechapter-\arabic{equation}}%
  \samplepagestyle{\leftmark}%
  \normalsize\songti
}
