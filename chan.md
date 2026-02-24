# 缠论主图 K 线绘图公式（笔 + 笔中枢 + 买卖点）

说明：需先建好 ZEN2 公式。若要以笔为单位画笔中枢，请在 ZEN2 中设置 `PIVOT:=0`（笔中枢）；默认 `PIVOT:=1` 为段中枢。

```
{==== 笔、笔中枢、背驰与买卖点主图 ====}
FRAC:=ZEN2.FRAC,NODRAW;
POLE_VALUE:=ZEN2.POLE_VALUE,NODRAW;
BISE:=ZEN2.BISE;
BIZG:=ZEN2.BIZG;
BIZD:=ZEN2.BIZD;
笔背离:=ZEN2.笔背离,NODRAW;
段背离:=ZEN2.段背离,NODRAW;
背驰:=ZEN2.背驰,NODRAW;

{---- 1. 以笔为单位连线 ----}
DRAWLINE(FRAC=-1,POLE_VALUE,FRAC=1,POLE_VALUE,0), DOTLINE, COLORRED;
DRAWLINE(FRAC=1,POLE_VALUE,FRAC=-1,POLE_VALUE,0), DOTLINE, COLORRED;

{---- 2. 笔中枢（ZEN2 中 PIVOT=0 时为笔中枢）----}
BIZG_LINE:IF(BIZG>0,BIZG,DRAWNULL),COLORBROWN;
BIZD_LINE:IF(BIZD>0,BIZD,DRAWNULL),COLORBROWN;
STICKLINE(BISE=-2 OR BISE=2,BIZD,BIZG,8,0),COLORBROWN;

{---- 3. 一买、二买、三买 ----}
DRAWICON(ZEN2.一买,L,1);
DRAWICON(ZEN2.二买,L,2);
DRAWICON(ZEN2.三买,L,3);
DRAWTEXT(ZEN2.一买,L*0.998,'1买');
DRAWTEXT(ZEN2.二买,L*0.998,'2买');
DRAWTEXT(ZEN2.三买,L*0.998,'3买');

{---- 4. 一卖、二卖、三卖 ----}
DRAWICON(ZEN2.一卖,H,11);
DRAWICON(ZEN2.二卖,H,12);
DRAWICON(ZEN2.三卖,H,13);
DRAWTEXT(ZEN2.一卖,H*1.002,'1卖');
DRAWTEXT(ZEN2.二卖,H*1.002,'2卖');
DRAWTEXT(ZEN2.三卖,H*1.002,'3卖');

{---- 5. 背驰/背离标记（可选）----}
DRAWICON(笔背离,IF(FRAC=-1,H,L),31);
DRAWICON(段背离,IF(FRAC=-1,H,L),32);
DRAWICON(背驰,IF(FRAC=-1,H,L),8);
```

---

# 选股公式（需先建好 ZEN2）

## 1、当日发生 1 买

```
ZEN2.一买;
```

## 2、先有 1 买再发生 2 买（当日 2 买且历史上出现过 1 买）

```
ZEN2.二买 AND BARSLAST(ZEN2.一买) > BARSLAST(ZEN2.二买);
```

## 3、先有 1 买、2 买再发生 3 买（当日 3 买且历史上按顺序出现过 1 买、2 买）

```
ZEN2.三买 AND BARSLAST(ZEN2.一买) > BARSLAST(ZEN2.二买) AND BARSLAST(ZEN2.二买) > BARSLAST(ZEN2.三买);
```
