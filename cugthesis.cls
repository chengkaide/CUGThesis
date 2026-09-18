% !TEX TS-program xelatex
% !TEX encoding = UTF-8 Unicode
% -*- coding: UTF-8; -*-
% vim: set fenc=utf-8

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  FileName: cugthesis.cls
%%  Author:   Timozer
%%  E-mail:   zhenyuwang94@gmail.com
%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{cugthesis}[2018/03/13 Version 0.1 China University of Geosciences Thesis Template]

\newif\ifcug@doctor\cug@doctorfalse
\newif\ifcug@master\cug@mastertrue  % default the student's degree is master
\newif\ifcug@masterprofulltime\cug@masterprofulltimefalse
\newif\ifcug@masterpronofulltime\cug@masterpronofulltimefalse
\newif\ifcug@bachelor\cug@bachelorfalse

\newif\ifcug@bib@style@sec\cug@bib@style@secfalse

% ---- 2026 新增开关 ----
\newif\ifcug@cover\cug@covertrue          % 是否生成中文封面（规范 1.1 / 附件12）
\newif\ifcug@frontmatterhead\cug@frontmatterheadfalse
    % 摘要、目录等前置部分是否显示页眉文字。
    % 规范 2.4 规定"页眉从第一章开始"，故默认关闭（只保留外侧页码）。

\DeclareOption{doctor}{\cug@doctortrue\cug@masterfalse\cug@masterprofulltimefalse\cug@masterpronofulltimefalse\cug@bachelorfalse}
\DeclareOption{master}{\cug@mastertrue\cug@doctorfalse\cug@masterprofulltimefalse\cug@masterpronofulltimefalse\cug@bachelorfalse}
\DeclareOption{masterprofulltime}{\cug@masterprofulltimetrue\cug@doctorfalse\cug@masterfalse\cug@masterpronofulltimefalse\cug@bachelorfalse}
\DeclareOption{masterpronofulltime}{\cug@masterpronofulltimetrue\cug@doctorfalse\cug@masterfalse\cug@masterprofulltimefalse\cug@bachelorfalse}
\DeclareOption{bachelor}{\cug@bachelortrue\cug@doctorfalse\cug@masterfalse\cug@masterprofulltimefalse\cug@masterpronofulltimefalse}
%\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}} % I don't want you to pass options to the ctexbook class

\DeclareOption{bibsec}{\cug@bib@style@sectrue}
\DeclareOption{nocover}{\cug@coverfalse}
\DeclareOption{frontmatterhead}{\cug@frontmatterheadtrue}
\ProcessOptions\relax

\LoadClass[ scheme=chinese, heading=true, %nofonts,
    12pt, utf8, a4paper, punct, fancyhdr, twoside, openright,
    amstex]{ctexbook}

%%%%%%%%%%%%%%%%%%%%%%% Load Packages %%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{xifthen, xparse, xstring, fancyhdr, etoolbox}

\RequirePackage{amstext, amsmath, amssymb, amsfonts}
\RequirePackage{mathrsfs, bm, mathtools}

\RequirePackage{graphicx}
\RequirePackage[labelformat=simple]{subcaption}

\RequirePackage{array, longtable, makecell, tabu, booktabs, multirow}

\RequirePackage{enumitem} % 修改列表样式

%------------------------------------------
\RequirePackage{cugthesisfont}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ctexset{%
    space=auto,
    autoindent=true,
    chapter={%
        afterindent=true,
        pagestyle=cug@pagestyle,
        aftername={\quad},
        format={\centering\sffamily\bfseries\cug@sanhao},
        beforeskip={2ex},
        afterskip={2ex},
        lofskip={0pt},
        lotskip={0pt},
% https://tex.stackexchange.com/questions/121879/remove-spacing-between-per-chapter-figures-in-lof
% list of figures and list of tables reduce the space between chapters
% for ctexbook class, we can use lofskip lotskip to set the space
% \patchcmd{<cmd>}{<search>}{<replace>}{<succes>}{<failure>}
%\patchcmd{\@chapter}{\CTEX@addloflotskip{chapter}}{}{}{} % lof lot
    },
    section={%
        afterindent=true,
        aftername={\quad},
        format={\centering\sffamily\bfseries\cug@sihao},
        beforeskip={1ex},
        afterskip={1ex},
    },
    subsection={%
        afterindent=true,
        aftername={\quad},
        format={\flushleft\sffamily\cug@xiaosi},
        beforeskip={1ex},
        afterskip={1ex},
    },
    subsubsection={%
        afterindent=true,
        format={\flushleft\sffamily\bfseries\cug@xiaosi},
        beforeskip={1ex},
        afterskip={1ex},
    },
    %paragraph/afterindent=true,
    appendix/numbering = true,
    appendix/name = {附录~}, % {前, 后}
    appendix/number = {\sffamily \Alph{chapter}},
}
% 附件 9 的图和表清单写作「图2-1」「表2-1」—— 章号与序号之间用连字符；
% 规范正文 2.5.1 却写作「图3.2」（点号）。两处冲突，按要求以附件为准。
% 注意章节本身的编号仍是「2.1」这种点号形式（参附件 8 的目录示例）。
\renewcommand{\thefigure}{\thechapter-\arabic{figure}}
\renewcommand{\thetable}{\thechapter-\arabic{table}}

\setlist{labelindent=\parindent, leftmargin=*}
%--------------- Page Layout ---------------
% 规范 3.1：A4，上、下、左、右均 3cm，装订线 0。
% 页眉 2.5cm / 页脚 2.0cm 是 Word 的说法，指「页眉顶端、页脚基线到纸张边缘的距离」。
% 旧版写作 headheight=2.5cm，那是把「页眉距纸边」误当成了「页眉区高度」，
% 结果页眉被顶到距纸边约 1.9cm（demo.pdf 实测）。此处按正确语义重新标定：
%   页眉文字顶部 ≈ 2.5cm，正文顶部 = 3cm，两者只差 0.5cm。
\RequirePackage[a4paper, 
    marginparwidth=0pt, marginparsep=0pt,
    top=3cm, bottom=3cm, left=3cm, right=3cm, 
    headheight=13pt, headsep=1.2pt, footskip=1cm]{geometry}
% 说明：fancyhdr 把页眉内容贴着 head 区顶部放置，而 head 区顶部
%      = top - headsep - headheight。规范要求页眉距纸边 2.5cm、正文 3cm，
%      两者只差 0.5cm，故取 headheight + headsep = 0.5cm，
%      其中 headheight 需容得下 10.5 磅的页眉行，剩给 headsep 的余量很小。

%--------------- 正文行距 ---------------
% 规范 3.6 / 3.8 / 3.9 均要求正文「固定值行距 20 磅，段前段后 0 磅」。
% LaTeX 里的「固定值」= 把 \baselineskip 钉死在 20pt，只能通过重定义
% \normalsize（内部用 \@setfontsize 同时设定字号与基线）实现；
% 单写一句 \setlength{\baselineskip}{20pt} 会在下一次 \selectfont 时被冲掉。
% 字号仍取 12bp（= 12.045pt，即规范所说的小四 12 磅）。
% 旧版此处完全没有设置行距，用的是 ctexbook 的默认倍数行距（实测 18.8pt 上下浮动）。
%
% \baselinestretch 必须先复位为 1：ctex 默认按 1.3 倍行距排版，
% 若不复位，下面写死的 20pt 会被再乘 1.3 变成 26pt。
% 复位之后，各级标题的行距由 cugthesisfont.sty 中各自的倍数额外控制。
\linespread{1}%
\renewcommand{\normalsize}{%
    \@setfontsize\normalsize{12bp}{20pt}%
    \abovedisplayskip      12\p@ \@plus3\p@ \@minus7\p@
    \abovedisplayshortskip \z@  \@plus3\p@
    \belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@
    \belowdisplayskip      \abovedisplayskip
    \let\@listi\@listI}
\normalsize
\setlength{\parskip}{0pt}
%-------------------------封面制作---------------------------
\newcommand{\tabincell}[2]{\begin{tabular}{@{}#1@{}}#2\end{tabular}}

\def\cug@define@term#1{
    \expandafter\gdef\csname #1\endcsname##1{%
        \expandafter\gdef\csname cug@#1\endcsname{##1}
    }
    \csname #1\endcsname{}
}

\cug@define@term{@titlelogo}
\cug@define@term{@entitlelogo}
%\cug@define@term{title}
\cug@define@term{entitle}
\newcommand{\cugthesistitle}[2]{%
    \title{#1}
    \entitle{#2}
}
%\cug@define@term{author}
\cug@define@term{enauthor}
\newcommand{\cugthesisauthor}[2]{%
    \author{#1}
    \enauthor{#2}
}
\cug@define@term{studentid}
\cug@define@term{major}
\cug@define@term{enmajor}
\newcommand{\cugthesismajor}[2]{%
    \major{#1}
    \enmajor{#2}
}
\cug@define@term{teacher}
\cug@define@term{supervisor}
\newcommand{\cugthesisteacher}[2]{%
    \teacher{#1}
    \supervisor{#2}
}
\cug@define@term{teachert}
\cug@define@term{supervisort}
\newcommand{\cugthesisteachertwo}[2]{%
    \teachert{#1}
    \supervisort{#2}
}
\cug@define@term{educatingunit}
\ifcug@masterpronofulltime
    \cug@define@term{corporatementor}
\fi
\RequirePackage{zhnumber}
% 规范 1.1 与附件 1 的日期写法为「二○二五年五月」。
% 注意附件里那个圈是 U+25CB「○」（几何图形区的 WHITE CIRCLE），
% 但该字符在宋体中的字形又小又靠下，印出来像句号 —— demo.pdf 实测如此。
% 这里改用 U+3007「〇」（中日韩表意文字区的数字零），在宋体里是全角、
% 大小与位置都正确的字形，视觉上才是规范想要的样子。
% 若确实需要严格复现附件的字符码点，把 \zhdigits 的输出做一次
% \StrSubstitute{〇}{○} 即可（xstring 已加载）。
\newcommand{\cugthesisdate}[2]{%
    \date{\zhdigits{#1} 年 \zhdigits{#2} 月}%
}
%\cug@define@term{date}
\newcommand{\cug@degree@cn}{硕士}
\newcommand{\cug@degree@en}{Master}
\newcommand{\cug@info@table@majorname}{学科专业}
\newcommand{\cug@info@entable@majorname}{Major}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifcug@doctor
    \@titlelogo{博士学位论文}
    \@entitlelogo{A Dissertation Submitted to China University of Geosciences \\ For the Doctor Degree of \cug@enmajor} 
    \renewcommand{\cug@degree@cn}{博士}
    \renewcommand{\cug@degree@en}{Ph.D.}
\fi
\ifcug@master
    \@titlelogo{硕士学位论文}
    \@entitlelogo{A Dissertation Submitted to China University of Geosciences \\ For the Master Degree of \cug@enmajor} 
\fi
\ifcug@masterprofulltime
    \@titlelogo{硕士专业学位论文（全日制）}
    \@entitlelogo{A Dissertation Submitted to China University of Geosciences \\ For the Full-Time Master of Professional Degree of \\ \cug@enmajor} 
    \renewcommand{\cug@info@table@majorname}{专业学位类别}
    \renewcommand{\cug@info@entable@majorname}{Professional Degree Category}
\fi
\ifcug@masterpronofulltime
    \@titlelogo{硕士专业学位论文（非全日制）}
    \@entitlelogo{A Dissertation Submitted to China University of Geosciences \\ For the Part-Time Master of Professional Degree of \\ \cug@enmajor} 
    \renewcommand{\cug@info@table@majorname}{专业学位类别}
    \renewcommand{\cug@info@entable@majorname}{Professional Degree Category}
\fi
\ifcug@bachelor
    % 本科封面标题。学校未在附件 12 中给出本科版式，此处沿用同一版式，
    % 仅把标题写作「本科生毕业论文」。若学院另有规定，改这一行即可。
    \@titlelogo{本科生毕业论文}
    \@entitlelogo{A Dissertation Submitted to China University of Geosciences \\ For the Bachelor Degree of \\ \cug@enmajor}
    \renewcommand{\cug@degree@cn}{学士}
    \renewcommand{\cug@degree@en}{Bachelor}
\fi

% 附件 1 的首行是 4 列等宽表格（各 109.3 磅）：
% 「学校代码：」右对齐、「10491」左对齐、「研究生学号：」右对齐、最后是取值。
% 旧版用 \hfill 把学号推到纸边，与附件的中间偏右位置不同。
\newcommand{\cug@studentidline}[1]{%
    \begin{tabular}{@{}l@{}l@{}l@{}l@{}}
        \makebox[0.25\textwidth][r]{学校代码：} & \makebox[0.25\textwidth][l]{10491}%
        & \makebox[0.25\textwidth][r]{#1：} & \makebox[0.25\textwidth][l]{\cug@studentid}
    \end{tabular}}

% 附件 1 的题名页标签写作「姓　名：」「学 科 专 业：」「指 导 教 师：」
% 「培 养 单 位：」—— 字与字之间留空，冒号统一落在同一列。
% 这里用分散对齐撑满固定宽度来实现：标签只给字，冒号由宏补上。
% 宽度取附件实测值：普通学位 114.8 磅，专硕（「专业学位类别」6 字）122.8 磅。
\newcommand{\cug@info@table@labelwidth}{114.8pt}
\ifcug@masterprofulltime
    \renewcommand{\cug@info@table@labelwidth}{122.8pt}
\fi
\ifcug@masterpronofulltime
    \renewcommand{\cug@info@table@labelwidth}{122.8pt}
\fi
\newcommand{\cug@info@table@item}[2]{%
    \makebox[\cug@info@table@labelwidth][s]{#1}： & \makebox[8em][l]{#2} & \\
}
\newcommand{\cug@info@table}{%
    \begin{tabular}{clc}
        \cug@info@table@item{姓名}{\@author}
        \cug@info@table@item{\cug@info@table@majorname}{\cug@major}
        \cug@info@table@item{指导教师}{\cug@teacher}
        \ifx\cug@teachert\empty
        \else
            % 第二导师行没有标签，但要与上一行的取值左对齐
            \hspace*{\cug@info@table@labelwidth}\hspace*{1\ccwd} & \cug@teachert & \\
        \fi
        \ifcug@masterpronofulltime
            \cug@info@table@item{企业导师}{\cug@corporatementor}
        \fi
        \cug@info@table@item{培养单位}{\cug@educatingunit}
    \end{tabular}
}
% 附件 2 的英文题名页用的是全角冒号（Ph.D. Candidate： / Major： / Supervisor：）
\newcommand{\cug@info@entable}{%
    \begin{tabular}{>{\raggedleft}p{.4\textwidth}p{.45\textwidth}p{.15\textwidth}}
        \cug@degree@en\ Candidate： & \cug@enauthor &\\
        \cug@info@entable@majorname： & \cug@enmajor &\\
        Supervisor： & \ifx\cug@supervisort\empty\cug@supervisor\else\multirow[t]{2}{8em}{\cug@supervisor \\\cug@supervisort}\fi &
    \end{tabular}
}

%--------------- Title Page ----------------
\newcommand{\cug@make@title}{
    \begin{titlepage}
        \thispagestyle{empty}
        \begin{center}\leavevmode
            \ifcug@bachelor
                {\cug@sanhao\cug@studentidline{本科生学号}}
            \else
                {\cug@sanhao\cug@studentidline{研究生学号}}
            \fi
            \vspace*{2\baselineskip}
            {\par \cug@yihao \bfseries 中国地质大学\\ \cug@@titlelogo \par}
            \vspace*{2.5\baselineskip}
            {\par \cug@erhao \sffamily \bfseries \@title \par} %
            \vfill
            {\cug@sanhao \cug@info@table}
            \vfill
            {\cug@sanhao{\@date}}%
            \vspace*{\baselineskip}
        \end{center}
        \clearpage
        \thispagestyle{empty}
    \end{titlepage}
}
%\renewcommand\arraystretch{1} % 将行距还原

\newcommand{\cug@make@entitle}{%
    \cleardoublepage 
    \thispagestyle{empty}
    \begin{center}
        \leavevmode
        \vspace*{\baselineskip}
        {\par \cug@sanhao \cug@@entitlelogo \par}
        \vfill
        {\par \cug@erhao \bfseries \cug@entitle \par}
        \vfill
        {\cug@sanhao \cug@info@entable}
        \vfill
        {\cug@sanhao 
            China University of Geosciences

            Wuhan 430074 P.R. China
        }
        \vspace*{\baselineskip}
    \end{center}
    \clearpage
    \thispagestyle{empty}
}
% \newtoks 必须写在宏体之外：\makeextrapages 会调用本宏三次，
% 写在宏内会在第 2、3 次抛「Command \@extrapages@content already defined」。
% 旧版即如此 —— 三张声明页仍能正常生成，但编译日志留下两处错误，
% 在 Overleaf 上会被误判为「编译失败」。
\newtoks\@extrapages@content
\newcommand{\cug@extrapages@headername}{研究生学位论文}

% ---- 声明类页面的版式参数 ----
% 数值取自附件 3/4/5 的实际格式（由「2025修改：附件1-11.doc」导出的 OOXML 解析得到）：
%   附件 3 原创性声明：四号 14 磅，2 倍行距，正文首行缩进 28 磅，落款左缩进 189 磅
%   附件 4 导师承诺书：四号 14 磅，2 倍行距，正文首行缩进 21 磅，落款左缩进 147 磅
%   附件 5 使用授权书：四号 14 磅，1.5 倍行距，正文首行缩进 28 磅，落款左缩进 203 磅
% 「2 倍」「1.5 倍」按 14 磅字号折算为固定行距 33.6 磅、25.2 磅。
% 旧版这三页照抄了正文的小四 12 磅 + 固定 20 磅，比附件紧得多，三页放在一起
% 与正文观感明显不一致 —— 这正是「声明页行距有问题」的根源。
\newcommand{\cug@ra@line}{33.6pt}
\newcommand{\cug@ra@parindent}{28pt}
\newcommand{\cug@ra@signindent}{189pt}

\newcommand{\cug@make@extrapages}[1]{%
    \cug@define@term{@extrapages@type}
    \cug@define@term{@extrapages@signature}
    \renewcommand{\cug@extrapages@headername}{研究生学位论文}%
    \renewcommand{\cug@ra@line}{33.6pt}%
    \renewcommand{\cug@ra@parindent}{28pt}%
    \renewcommand{\cug@ra@signindent}{189pt}%
    \ifnum#1=1
        \@extrapages@type{原创性声明}
        \@extrapages@content{%
            本人郑重声明：本人所呈交的\cug@degree@cn{}学位论文《\@title》，是本人在导师的指导下，在中国地质大学（武汉）攻读\cug@degree@cn{}学位期间独立进行研究工作所取得的成果。论文中除已注明部分外不包含他人已发表或撰写过的研究成果，对论文的完成提供过帮助的有关人员已在文中说明并致以谢意。\par
            本人所呈交的\cug@degree@cn{}学位论文没有违反学术道德和学术规范，没有侵权行为，并愿意承担由此而产生的法律责任和法律后果。%
        }
        \@extrapages@signature{学位论文作者签名}
    \else
        \ifnum#1=2
            \@extrapages@type{导师承诺书}
            \renewcommand{\cug@ra@parindent}{21pt}%
            \renewcommand{\cug@ra@signindent}{147pt}%
            \@extrapages@content{%
                本人郑重承诺：本人所指导的\cug@degree@cn{}学位论文《\@title》是在本人的指导下，研究生在中国地质大学（武汉）攻读\cug@degree@cn{}学位期间独立进行研究工作所取得的成果，论文由研究生独立完成。\par
                研究生所呈交的\cug@degree@cn{}学位论文没有违反学术道德和学术规范，没有侵权行为，并愿意承担由此而产生的与导师相关的责任和后果。%
            }
            \@extrapages@signature{指导教师（签字）}
        \else
            \ifnum#1=3
                \@extrapages@type{使用授权书}
                % 附件 5 的标题是「中国地质大学（武汉）学位论文使用授权书」，
                % 比原创性声明、导师承诺书少「研究生」三字。
                \renewcommand{\cug@extrapages@headername}{学位论文}%
                \renewcommand{\cug@ra@line}{25.2pt}%
                \renewcommand{\cug@ra@parindent}{28pt}%
                \renewcommand{\cug@ra@signindent}{203pt}%
                \@extrapages@content{%
                    本人授权中国地质大学（武汉）可采用影印、缩印、数字化或其它复制手段保存本学位论文；学校可向国家有关部门或机构送交本学位论文的电子版全文，编入有关数据库进行检索、下载及文献传递服务；同意在校园网内提供全文浏览和下载服务。\par
                    涉密论文解密后适用于本授权书。%
                }
                \@extrapages@signature{学位论文作者签名}
            \else
                \ClassError{CUGThesis}{Class Internal Error, In command makeextrapages. I don't know which page to generate.}{}
            \fi
        \fi
    \fi
    \cleardoublepage
    \vskip \baselineskip
    \ifcug@bachelor
        {\sffamily\cug@sanhao{中国地质大学（武汉）本科生学位论文\cug@@extrapages@type}}
    \else
        {\sffamily\cug@sanhao{中国地质大学（武汉）\cug@extrapages@headername\cug@@extrapages@type}}
    \fi
    \vskip 1.5\baselineskip
    % 正文：四号 14 磅 + 附件给定的行距。
    % 附件里两段之间没有额外空距（段间距就等于行距），所以这里用真正的分段 \par，
    % 而不是旧版那种「\\[0.8\baselineskip]」——后者在 LaTeX 里只换行不分段。
    {\fontsize{14bp}{\cug@ra@line}\selectfont
        \setlength{\parindent}{\cug@ra@parindent}%
        \setlength{\parskip}{0pt}%
        \the\@extrapages@content\par}%
    \vskip 2\baselineskip
    {\fontsize{14bp}{\cug@ra@line}\selectfont
        \setlength{\parindent}{0pt}%
        \noindent\hspace*{\cug@ra@signindent}\cug@@extrapages@signature：\makebox[4em][l]{}%
        \par\vskip 0.2\baselineskip
        \noindent\hspace*{\cug@ra@signindent}\makebox[3.35em][s]{日期}：~\makebox[9em][r]{\qquad 年 \quad 月 \quad 日}\par}%
    \clearpage
}
\newcounter{cug@authorcv@section}
\newcommand{\cugauthorcvsection}[1]{%
    \stepcounter{cug@authorcv@section}
    {\par \sffamily\bfseries \noindent \chinese{cug@authorcv@section}、 #1}\par
}
\newcommand{\cugauthorcvinfoitem}[3]{%
    \hspace{2.6em} \makebox[3em][r]{#1} -- \makebox[3em][l]{#2}\quad  #3; \hfill\par 
}
\newcommand{\cug@make@authorcv}{%
    \cleardoublepage
    \leavevmode 
    \vspace*{\baselineskip}
    % 附件 6 的实际标题是「作者简历」（规范 1.6 正文里叫「作者简介」），以附件为准
    {\hfill{\cug@sanhao\sffamily\bfseries 作者简历}\hfill}
    \vspace*{\baselineskip}
    % 正文行距已由 \normalsize 固定为 20 磅，不必在此临时改写 \baselineskip
    % （旧版改了也没用：\input 里的字体切换会把 \baselineskip 重置回去）
    \input{authorcv}%
    \clearpage
}

%%%%%%%%%%%%%%%%%%%%%% 中文封面（规范 1.1 / 附件 12）%%%%%%%%%%%%%%%%%%%%%%
% 封面是学校统一印制的艺术版式，无法用 LaTeX 复刻，因此以附件 12 的官方图作底图，
% 再把各字段叠印到测量出的位置上。
% 注意：附件 12 原图是「封底 + 封面」的横向拼版，本模板使用的是裁出的右半（封面），
% 存于 cover/ 目录。封面版式的著作权归中国地质大学（武汉）所有，仅供本校学位论文使用。
\RequirePackage{tikz}

%---- 封面专用字段（规范 1.1）----
\cug@define@term{cugclassnumber}    % 分类号
\cug@define@term{cugsecretlevel}    % 密级

%---- 底图按学位类型选择 ----
\newcommand{\cug@coverimage}{}
\ifcug@doctor
    \renewcommand{\cug@coverimage}{cover/doctor.jpg}
\fi
\ifcug@master
    \renewcommand{\cug@coverimage}{cover/master.jpg}
\fi
\ifcug@masterprofulltime
    \renewcommand{\cug@coverimage}{cover/masterpro-fulltime.jpg}
\fi
\ifcug@masterpronofulltime
    \renewcommand{\cug@coverimage}{cover/masterpro-parttime.jpg}
\fi
% 附件 12 只给了博士、硕士、专硕（全日制/非全日制）四种底图，没有本科版。
% 底图本身是通用版式（只有「分类号：」「密　级：」和校名，不含学位类型文字），
% 故本科沿用同一版式的蓝色底图；拿到学校本科专用底图后，替换 cover/bachelor.jpg 即可。
\ifcug@bachelor
    \renewcommand{\cug@coverimage}{cover/bachelor.jpg}
\fi

%---- 信息区标签宽度：专硕的标签是「专业学位类别」（6 字），其余为 4 字 ----
\newcommand{\cug@cover@labelwidth}{5\ccwd}
\ifcug@masterprofulltime
    \renewcommand{\cug@cover@labelwidth}{7\ccwd}
\fi
\ifcug@masterpronofulltime
    \renewcommand{\cug@cover@labelwidth}{7\ccwd}
\fi

% 标签用分散对齐撑满固定宽度，使各行取值纵向对齐（附件 12 的做法）。
% 宽度取 \cug@cover@labelwidth 减一个汉字符，让出冒号的位置；
% 专硕的标签是「专业学位类别」（6 字），故宽度按学位类型在上面已分别设定。
\newcommand{\cug@cover@label}[1]{%
    \makebox[\dimexpr\cug@cover@labelwidth-1\ccwd\relax][s]{#1}：}
\newcommand{\cug@cover@font}{\cug@sanhao\sffamily\bfseries}
\newcommand{\cug@cover@linegap}{0.49cm}

\newcommand{\cug@cover@lines}{%
    \cug@cover@label{学号}\cug@studentid \\[\cug@cover@linegap]
    \cug@cover@label{姓名}\@author \\[\cug@cover@linegap]
    \cug@cover@label{\cug@info@table@majorname}\cug@major \\[\cug@cover@linegap]
    \cug@cover@label{指导教师}\cug@teacher \\[\cug@cover@linegap]
    \ifx\cug@teachert\empty
    \else
        \hspace*{\cug@cover@labelwidth}\cug@teachert \\[\cug@cover@linegap]
    \fi
    \ifcug@masterpronofulltime
        \cug@cover@label{企业导师}\cug@corporatementor \\[\cug@cover@linegap]
    \fi
    \cug@cover@label{培养单位}\cug@educatingunit
}

%---- 封面排版 ----
% 纵向位置取自对附件 12「封面样式」图逐行检测的结果（单位 cm，自纸张上边缘起算）。
\newcommand{\cug@make@cover}{%
    \begin{titlepage}%
    \thispagestyle{empty}%
    \begin{tikzpicture}[remember picture, overlay]
        \node[inner sep=0pt, anchor=center] at (current page.center) {%
            \includegraphics[width=\paperwidth, height=\paperheight]{\cug@coverimage}};
        % 分类号 / 密级
        % 底图上已经印好「分类号：」（1.77~3.86cm）与「密　级：」（13.90~15.80cm），
        % 这里只把取值填到标签右侧，不能再印一遍标签（会与底图重影）。
        % 取值起点 = 标签右缘 + 约 0.25cm，避免与底图的冒号贴在一起。
        \node[anchor=west, inner sep=0pt, font=\cug@cover@font]
            at ([xshift=4.10cm, yshift=-2.20cm]current page.north west)
            {\cug@cugclassnumber};
        \node[anchor=west, inner sep=0pt, font=\cug@cover@font]
            at ([xshift=16.05cm, yshift=-2.20cm]current page.north west)
            {\cug@cugsecretlevel};
        % 学位论文类型（宋体 26 磅加粗）
        \node[anchor=center, inner sep=0pt, font=\cug@yihao\sffamily\bfseries]
            at ([xshift=10.5cm, yshift=-10.54cm]current page.north west)
            {\cug@@titlelogo};
        % 论文题目（黑体 22 磅加粗居中，可分两行）
        \node[anchor=north, inner sep=0pt, text width=15cm, align=center,
              font=\cug@erhao\sffamily\bfseries]
            at ([xshift=10.5cm, yshift=-12.05cm]current page.north west)
            {\@title};
        % 学号 / 姓名 / 学科专业 / 指导教师 / 培养单位（首行文字中心 16.78cm，行距 1.22cm）
        \node[anchor=north west, inner sep=0pt, align=left, font=\cug@cover@font]
            at ([xshift=6.4cm, yshift=-16.53cm]current page.north west)
            {\cug@cover@lines};
        % 日期（汉字，不用阿拉伯数字）
        \node[anchor=center, inner sep=0pt, font=\cug@cover@font]
            at ([xshift=10.5cm, yshift=-28.15cm]current page.north west)
            {\@date};
    \end{tikzpicture}%
    \end{titlepage}%
    \clearpage
}

%%%%%%%%%%%%%%%% 学位论文答辩委员会名单（规范 1.7 / 附件 7）%%%%%%%%%%%%%%%%%%
% 规范要求把答辩委员会名单编在中文摘要之前，作为学位论文的组成部分，
% 归档的电子版与纸质版都需要。旧版模板没有实现这一页。
\newcommand{\cug@committee@body}{}
\newcommand{\cugcommitteemember}[4]{%
    % #1 职务（主席 / 委员 / 秘书）  #2 姓名  #3 职称  #4 单位
    \appto\cug@committee@body{#1 & #2 & #3 & #4 \\[0.5\baselineskip]}%
}
\newcommand{\makecommitteelist}{%
    \cleardoublepage
    \thispagestyle{empty}%
    \phantomsection
    \vspace*{\baselineskip}
    \begin{center}
        {\cug@erhao\sffamily\bfseries 学位论文答辩委员会名单}
    \end{center}
    \vspace{2\baselineskip}
    \begin{center}
        {\cug@sanhao
        \begin{tabular}{@{}l@{\quad}l@{\quad}l@{\quad}l@{}}
            \cug@committee@body
        \end{tabular}}
    \end{center}
    \clearpage
}

\newtoks\cug@abstract
\newtoks\cug@enabstract
\newtoks\cug@keywords
\newtoks\cug@enkeywords
\newcommand{\cugabstract}[2]{%
    \cug@abstract{#1}
    \cug@enabstract{#2}
}
\newcommand{\cugkeywords}[2]{%
    \cug@keywords{#1}
    \cug@enkeywords{#2}
}

% 规范 3.6：中文摘要标题为「黑体 18 磅（或小二）加粗居中」，
% Abstract 标题为「Times New Roman 18 磅（或小二）加粗居中」。
% 旧版直接沿用 \AppChapter，套的是章标题格式（16 磅），小了一档。
\newcommand{\cug@make@abstract}{%
    \cleardoublepage 
    \phantomsection
    \addcontentsline{toc}{chapter}{摘\quad 要}%
    \chapter*{\cug@xiaoer 摘\quad 要}%
    \cug@frontmatter@thispage
    \setcounter{page}{1}
    {\normalsize
    \the\cug@abstract 
    }
    \vskip .5\baselineskip 
    \noindent
    {\normalsize {\bfseries 关键词:}\hskip0.5em \the\cug@keywords}
    \clearpage 
}
\newcommand{\cug@make@enabstract}{%
    \cleardoublepage 
    \phantomsection
    \addcontentsline{toc}{chapter}{Abstract}%
    \chapter*{\cug@xiaoer Abstract}%
    \cug@frontmatter@thispage
    {\normalsize
    \the\cug@enabstract 
    }
    \vskip .5\baselineskip 
    \noindent
    {\normalsize {\bfseries Keywords:}\hskip0.5em \the\cug@enkeywords}
    \clearpage 
}
%%%%%%%%%%%%%%%% List of Contents Format %%%%%%%%%%%%%%%%%%
\RequirePackage[titles]{tocloft}
\tocloftpagestyle{cug@pagestyle}
\setlength{\cftbeforechapskip}{0pt}
\setlength{\cftbeforesecskip}{0pt}
\setlength{\cftbeforesubsecskip}{0pt}
\setlength{\cftchapindent}{0em}
% 规范 3.7：一级节标题左缩进 1 个汉字符，二级节标题左缩进 2 个汉字符。
% 旧版为 1.2 / 2.5 —— 作者在 demo.tex 的更新日志里自述是「擅自」调整的。
\setlength{\cftsecindent}{18pt}
\setlength{\cftsubsecindent}{36pt}
% 规范 3.7：目录条目亦为「固定值行距 20 磅」。
% 行距直接写进条目字体设置里 —— 正文已把 \baselinestretch 复位为 1，
% 若只写 \cug@sihao（14bp），条目行距会塌成 14 磅。
\renewcommand{\cftchapfont}{\fontsize{14bp}{20pt}\selectfont}
\renewcommand{\cftsecfont}{\fontsize{12bp}{20pt}\selectfont}
\renewcommand{\cftsubsecfont}{\fontsize{12bp}{20pt}\selectfont}
\renewcommand{\cftfigfont}{\fontsize{12bp}{20pt}\selectfont}
\renewcommand{\cfttabfont}{\fontsize{12bp}{20pt}\selectfont}
\renewcommand{\cftchapleader}{\cftdotfill{\cftsecdotsep}}
% 规范 3.1：页码为五号（10.5 磅）。旧版目录页码跟着条目字号变成了 12 磅。
\renewcommand{\cftchappagefont}{\fontsize{10.5bp}{20pt}\selectfont}
\renewcommand{\cftsecpagefont}{\fontsize{10.5bp}{20pt}\selectfont}
\renewcommand{\cftsubsecpagefont}{\fontsize{10.5bp}{20pt}\selectfont}
\renewcommand{\cftfigpagefont}{\fontsize{10.5bp}{20pt}\selectfont}
\renewcommand{\cfttabpagefont}{\fontsize{10.5bp}{20pt}\selectfont}
% 规范 1.11 与附件 9：清单名称为「图清单」「表清单」，
% 旧版沿用了 ctex 默认的「插图」「表格」。
\renewcommand{\listfigurename}{图清单}
\renewcommand{\listtablename}{表清单}
% 附件 8 的目录标题写作「目  录」（字间留空）
\renewcommand{\contentsname}{目\quad 录}
% 附件 8：「目  录」为三号 16 磅加粗黑体，居中。
\renewcommand{\cfttoctitlefont}{\hfill\cug@sanhao\sffamily\bfseries}
\renewcommand{\cftaftertoctitle}{\hfill}
% 附件 9：「图清单」「表清单」为小二 18 磅、非加粗、居中。
% 注意：ctexbook 把 \listoffigures / \listoftables 的标题套成了章标题格式
% （实测渲染为三号 16 磅黑体），tocloft 的 \cftloftitlefont 在 ctexbook 下不生效，
% 所以下面把这两个命令整个重定义，标题格式完全自己控制。
\newcommand{\cug@listtitlefont}{\centering\normalfont\fontsize{18bp}{24pt}\selectfont}
\renewcommand{\listoffigures}{%
    \cleardoublepage
    \phantomsection
    {\cug@listtitlefont \listfigurename\par}%
    \vspace{\baselineskip}%
    \@starttoc{lof}%
}
\renewcommand{\listoftables}{%
    \cleardoublepage
    \phantomsection
    {\cug@listtitlefont \listtablename\par}%
    \vspace{\baselineskip}%
    \@starttoc{lot}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%------------------ 目录中的超链接(pdf 文档) ----------------------
\RequirePackage[unicode=true, pdfusetitle,
    bookmarks=true, bookmarksnumbered=false,
    bookmarksopen=false, breaklinks=false,
    pdfborder={0 0 1}, hidelinks=true,
    backref=false, colorlinks=false]{hyperref}
\RequirePackage{url}
\expandafter\def\expandafter\UrlBreaks\expandafter{\UrlBreaks%  save the current one
  \do\a\do\b\do\c\do\d\do\e\do\f\do\g\do\h\do\i\do\j%
    \do\k\do\l\do\m\do\n\do\o\do\p\do\q\do\r\do\s\do\t%
      \do\u\do\v\do\w\do\x\do\y\do\z\do\A\do\B\do\C\do\D%
        \do\E\do\F\do\G\do\H\do\I\do\J\do\K\do\L\do\M\do\N%
          \do\O\do\P\do\Q\do\R\do\S\do\T\do\U\do\V\do\W\do\X%
            \do\Y\do\Z\do\*\do\-\do\~\do\'\do\"\do\-}

\fancypagestyle{cug@pagestyle}{%
    \pagestyle{fancy}
    \fancyhf{}
    \fancyhead[CO]{\cug@wuhao 中国地质大学\cug@@titlelogo}
    \fancyhead[RO, LE]{\cug@wuhao \thepage}
    \fancyhead[CE]{\cug@wuhao \@author: \@title}
    \renewcommand{\headrulewidth}{0.4pt}
}
% 前置部分（摘要、Abstract、目录、图清单、表清单）使用：只保留外侧页码。
% 依据规范 2.4「页眉从第一章开始到论文最后一页均需设置」，
% 且附件 8 的目录式样中并未出现页眉。
% 旧版在这些页上也印了完整页眉（demo.pdf 实测 p12/p14/p16/p18/p20）。
% 若学院另有要求，加载类时加 frontmatterhead 选项即可恢复旧行为。
\fancypagestyle{cug@frontpagestyle}{%
    \pagestyle{fancy}
    \fancyhf{}
    \fancyhead[RO, LE]{\cug@wuhao \thepage}
    \renewcommand{\headrulewidth}{0pt}
}
% 横向页（pdflscape 的 landscape 环境）用：只保留外侧页码。
% 页面被旋转 90° 后，页眉文字会偏离常规位置甚至落到可视范围之外，
% 而页码在旋转后仍位于纸张边角，保留它便于装订后查阅。
% 用法：\begin{landscape}\thispagestyle{cuglandscape}...
\fancypagestyle{cuglandscape}{%
    \pagestyle{fancy}
    \fancyhf{}
    \fancyhead[RO, LE]{\cug@wuhao \thepage}
    \renewcommand{\headrulewidth}{0pt}
}
% ctexset 里给 chapter 设了 pagestyle=cug@pagestyle，摘要、目录这些
% 用 \chapter* 生成的前置页也会套用，因此每次生成后要再压一次本页样式。
\newcommand{\cug@frontmatter@thispage}{%
    \ifcug@frontmatterhead
    \else
        \thispagestyle{cug@frontpagestyle}%
    \fi
}
%------ 重新定义 frontmatter, mainmatter, backmatter
\newcommand{\emptymatter}{%
    \clearpage
    \pagestyle{empty}
}

\renewcommand{\frontmatter}{%
    \clearpage
    \pagenumbering{Roman}
    \ifcug@frontmatterhead
        \pagestyle{cug@pagestyle}%
    \else
        \pagestyle{cug@frontpagestyle}%
        % ctexset 给 chapter 指定了 pagestyle，\chapter* 生成的摘要、目录
        % 等首页会另用该样式。这里在前置部分把它一并换成无页眉样式 ——
        % 只靠 \thispagestyle 不够：目录跨页时首页可能在命令返回前就输出了。
        \ctexset{chapter/pagestyle=cug@frontpagestyle}%
    \fi
}
\renewcommand{\mainmatter}{%
    \clearpage
    \setcounter{chapter}{0}
    \pagenumbering{arabic}
    \ifcug@frontmatterhead
    \else
        \ctexset{chapter/pagestyle=cug@pagestyle}%   % 正文恢复完整页眉
    \fi
}

\let\cug@appendix = \appendix
\renewcommand{\appendix}{
    \setcounter{chapter}{0}
    \cug@appendix 
    \@mainmattertrue
}

\newcommand{\AppChapter}[1]{%
    \phantomsection
    \addcontentsline{toc}{chapter}{#1}
    \chapter*{#1}
}

\newcommand{\cugthesisacknowledgements}{%
    \phantomsection
    \chapter{致谢}
}
\newcommand{\cugthesisbib}[1]{%
    \cleardoublepage 
    \phantomsection
    \addcontentsline{toc}{chapter}{参考文献}
    \bibliography{#1}
}

% \RequirePackage{cleveref}
% \cref{label, label, ...}
% \crefrange{}{}
% \cpageref{label, label, ...}
% \cpagerefrange{label}{label}
% maybe i can use cleveref package to solve the problem
% \rmfamily, \sffamily, \ttfamily, \upshape, \itshape, \slshape, \scshape, \bfseries, \mdseries, \lfseries
% tex 中定义命令的语句 \def, \gdef, \edef, \xdef, \gdef -> \global\def
% \def<命令模板>{定义}
% \def\Emph#1{\bf{#1}}
% 排版文件目录树的宏包: dirtree, forest
\renewcommand{\maketitle}{%
    \cug@make@title
    \cug@make@entitle
}
\newcommand{\makeextrapages}{%
    \ifcug@bachelor
        \cug@make@extrapages{1}
    \else
        \cug@make@extrapages{1}
        \cug@make@extrapages{2}
        \cug@make@extrapages{3}
    \fi
}
\newcommand{\makeauthorcv}{%
    \cug@make@authorcv
}
\newcommand{\makeabstract}{%
    \ifcug@bachelor
        \cug@make@abstract
    \else
        \cug@make@abstract
        \cug@make@enabstract
    \fi
}
\newcommand{\makefrontpages}{%
    \ifcug@cover
        \cug@make@cover               % 中文封面（规范 1.1 / 附件12）
    \fi
    \maketitle                        % 中文题名页 + 英文题名页
    \emptymatter 
    \makeextrapages                   % 原创性声明 / 导师承诺书 / 使用授权书
    \makeauthorcv                     % 作者简介
    \makecommitteelist                % 答辩委员会名单（规范 1.7 / 附件7）
    \frontmatter 
    \makeabstract                     % 中文摘要 + Abstract
    \tableofcontents 
    \cug@frontmatter@thispage
    \listoffigures
    \cug@frontmatter@thispage
    \addcontentsline{toc}{chapter}{图清单}
    \listoftables 
    \cug@frontmatter@thispage
    \addcontentsline{toc}{chapter}{表清单}
    \clearpage 
    \mainmatter 
}

%%%%%%%%%%%%%%%%%%% 定制列表环境, 让它们看起来更紧凑一些 %%%%%%%%%%%%%%%%%%%%
\setlist[itemize]{parsep=0pt, itemsep=0pt, topsep=0pt, rightmargin=2em, partopsep=2pt}
\setlist[enumerate]{parsep=0pt, itemsep=0pt, topsep=0pt, rightmargin=2em, partopsep=2pt}
\setlist[description]{parsep=0pt, itemsep=0pt, topsep=0pt, rightmargin=2em, partopsep=2pt}
%\AtBeginEnvironment{itemize}{\small}
%\AtBeginEnvironment{enumerate}{\small}
%\AtBeginEnvironment{description}{\small}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% The format of float's caption %%%%%%%%%%%%%%%%%%%%
\RequirePackage{caption}
% 规范 3.8：图题、表题为五号（10.5 磅）宋体居中，序号与题名之间空 1 个汉字符。
% labelsep=quad 即 1 个 em，正是一个汉字符宽度。
% 旧版 font={small}，在 12pt 文档下 \small = 11pt，实测题注 10.91pt，偏大。
\DeclareCaptionFont{cugwuhao}{\fontsize{10.5bp}{14pt}\selectfont}
\captionsetup{labelsep=quad, font={cugwuhao,rm}, skip=10pt}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\let\oldequation=\theequation
\renewcommand{\theequation}{{\cug@wuhao\oldequation}}

% Logo
\NewDocumentCommand{\cugthesis}{}{CUGThesis}
% 参考文献
\RequirePackage[sort&compress]{natbib}
\ifcug@bib@style@sec
\bibliographystyle{gbt7714-2005-sec}
\else
\bibliographystyle{gbt7714-2005}
\fi
\bibpunct{[}{]}{;}{s}{}{;}
\addtolength{\bibsep}{-1.5ex}
%--------------- Source Code ---------------
\endinput 
