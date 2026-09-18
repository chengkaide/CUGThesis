TEX    = xelatex
BIBTEX = bibtex

OBJECTS = demo.pdf
target: $(OBJECTS)

# -shell-escape 是 minted（由 tcode.sty 加载）需要的；
# 如果你不使用 tcode 宏包，可以去掉这个选项。
demo.pdf: demo.tex *.sty *.cls *.tex Makefile
	$(TEX) -shell-escape -interaction=nonstopmode $<
	$(BIBTEX) demo.aux
	$(TEX) -shell-escape -interaction=nonstopmode $<
	$(TEX) -shell-escape -interaction=nonstopmode $<

.PHONY: clean open

# 旧版把 $(OPEN) 直接写进构建规则且取值为 macOS 的 open 命令，
# 在 Linux / Windows 上构建会因此报错，这里改成独立的可选目标。
open: $(OBJECTS)
	@(command -v open >/dev/null 2>&1 && open $(OBJECTS)) || xdg-open $(OBJECTS) || true

clean:
	rm -f *~ *.aux *.log *.out *.toc *.bbl *.blg *.lof *.lot
	rm -rf _minted-cache
