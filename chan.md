# 缠论主图 K 线绘图公式（笔 + 笔中枢 + 买卖点）

说明：需先建好 ZEN2 公式。若要以笔为单位画笔中枢，请在 ZEN2 中设置 `PIVOT:=0`（笔中枢）；默认 `PIVOT:=1` 为段中枢。买卖点按缠论连续性：买点序列内不出现一卖，卖点序列内不出现一买，仅显示有效二买/三买、有效二卖/三卖。

```
{==== 笔、笔中枢、背驰与买卖点主图（含连续性过滤）====}
FRAC:=ZEN2.FRAC,NODRAW;
POLE_VALUE:=ZEN2.POLE_VALUE,NODRAW;
BISE:=ZEN2.BISE;
BIZG:=ZEN2.BIZG;
BIZD:=ZEN2.BIZD;
笔背离:=ZEN2.笔背离,NODRAW;
段背离:=ZEN2.段背离,NODRAW;
背驰:=ZEN2.背驰,NODRAW;

{---- 有效买卖点：同一走势内、中间无反向一类信号 ----}
有效二买:=ZEN2.二买 AND BARSLAST(ZEN2.一买) > BARSLAST(ZEN2.二买) AND BARSLAST(ZEN2.一卖) > BARSLAST(ZEN2.一买);
有效三买:=ZEN2.三买 AND BARSLAST(ZEN2.一买) > BARSLAST(ZEN2.二买) AND BARSLAST(ZEN2.二买) > BARSLAST(ZEN2.三买) AND BARSLAST(ZEN2.一卖) > BARSLAST(ZEN2.一买);
有效二卖:=ZEN2.二卖 AND BARSLAST(ZEN2.一卖) > BARSLAST(ZEN2.二卖) AND BARSLAST(ZEN2.一买) > BARSLAST(ZEN2.一卖);
有效三卖:=ZEN2.三卖 AND BARSLAST(ZEN2.一卖) > BARSLAST(ZEN2.二卖) AND BARSLAST(ZEN2.二卖) > BARSLAST(ZEN2.三卖) AND BARSLAST(ZEN2.一买) > BARSLAST(ZEN2.一卖);

{---- 1. 以笔为单位连线 ----}
DRAWLINE(FRAC=-1,POLE_VALUE,FRAC=1,POLE_VALUE,0), DOTLINE, COLORRED;
DRAWLINE(FRAC=1,POLE_VALUE,FRAC=-1,POLE_VALUE,0), DOTLINE, COLORRED;

{---- 2. 笔中枢（ZEN2 中 PIVOT=0 时为笔中枢）----}
BIZG_LINE:IF(BIZG>0,BIZG,DRAWNULL),COLORBROWN;
BIZD_LINE:IF(BIZD>0,BIZD,DRAWNULL),COLORBROWN;
STICKLINE(BISE=-2 OR BISE=2,BIZD,BIZG,8,0),COLORBROWN;

{---- 3. 一买、有效二买、有效三买 ----}
DRAWICON(ZEN2.一买,L,1);
DRAWICON(有效二买,L,2);
DRAWICON(有效三买,L,3);
DRAWTEXT(ZEN2.一买,L*0.998,'1买');
DRAWTEXT(有效二买,L*0.998,'2买');
DRAWTEXT(有效三买,L*0.998,'3买');

{---- 4. 一卖、有效二卖、有效三卖 ----}
DRAWICON(ZEN2.一卖,H,11);
DRAWICON(有效二卖,H,12);
DRAWICON(有效三卖,H,13);
DRAWTEXT(ZEN2.一卖,H*1.002,'1卖');
DRAWTEXT(有效二卖,H*1.002,'2卖');
DRAWTEXT(有效三卖,H*1.002,'3卖');

{---- 5. 背驰/背离标记（可选）----}
DRAWICON(笔背离,IF(FRAC=-1,H,L),31);
DRAWICON(段背离,IF(FRAC=-1,H,L),32);
DRAWICON(背驰,IF(FRAC=-1,H,L),8);
```

---

# 选股公式（需先建好 ZEN2）

按缠论连续性：买点序列内不出现一卖，卖点序列内不出现一买。

## 1、当日发生 1 买

```
ZEN2.一买;
```

## 2、先有 1 买再发生 2 买（且 1 买后未出现过 1 卖）

```
ZEN2.二买 AND BARSLAST(ZEN2.一买) > BARSLAST(ZEN2.二买) AND BARSLAST(ZEN2.一卖) > BARSLAST(ZEN2.一买);
```

## 3、先有 1 买、2 买再发生 3 买（且 1 买后未出现过 1 卖）

```
ZEN2.三买 AND BARSLAST(ZEN2.一买) > BARSLAST(ZEN2.二买) AND BARSLAST(ZEN2.二买) > BARSLAST(ZEN2.三买) AND BARSLAST(ZEN2.一卖) > BARSLAST(ZEN2.一买);
```
