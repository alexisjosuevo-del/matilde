use strict;use warnings;
local $/;
my $file = shift @ARGV;
open my $fh,'<',$file or die $!;
my $s = <$fh>;
close $fh;

my $new = <<'CSS';
    /* Organigrama */
    .org-wrap{display:grid;grid-template-columns:1fr 1fr;gap:14px;align-items:start}
    .imggrid{display:grid;grid-template-columns:1fr;gap:12px}
    .imgcard{border:1px solid var(--border);background:rgba(255,255,255,.04);border-radius:var(--radius);padding:12px}
    .imgcard img{width:100%;height:auto;display:block;border-radius:12px;border:1px solid rgba(255,255,255,.08)}
    .imgcard figcaption{margin-top:8px;color:var(--muted);font-size:12px;line-height:1.35}

    .org-diagram{border:1px solid var(--border);background:rgba(255,255,255,.04);border-radius:var(--radius);padding:12px;cursor:zoom-in;position:relative;overflow:hidden;transition:transform .22s ease,border-color .22s ease,box-shadow .22s ease}
    .org-diagram:hover{transform:translateY(-1px);border-color:rgba(53,208,179,.28);box-shadow:0 18px 50px rgba(0,0,0,.38)}
    .org-diagram:after{content:"Click para expandir";position:absolute;top:12px;left:12px;font-size:12px;color:rgba(234,240,255,.92);background:rgba(0,0,0,.22);border:1px solid rgba(255,255,255,.14);padding:7px 10px;border-radius:999px;backdrop-filter:blur(8px)}
    .org-diagram svg{width:100%;height:auto;display:block;transition:transform .25s ease;transform-origin:center}
    .org-diagram:hover svg{transform:scale(1.02)}

    .legend{display:flex;gap:8px;flex-wrap:wrap;margin-top:10px}
    .chip{display:inline-flex;align-items:center;gap:6px;border:1px solid rgba(255,255,255,.12);background:rgba(255,255,255,.04);border-radius:999px;padding:7px 10px;font-size:12px;color:var(--muted)}
    .chip b{color:var(--text)}

    .org-modal{position:fixed;inset:0;z-index:200;display:none;align-items:center;justify-content:center;padding:18px;background:rgba(0,0,0,.72);backdrop-filter:blur(10px)}
    .org-modal.open{display:flex}
    .org-modal .panel{width:min(1100px,96vw);height:min(84vh,760px);background:rgba(18,26,51,.92);border:1px solid var(--border);border-radius:22px;box-shadow:0 20px 70px rgba(0,0,0,.60);overflow:hidden;display:flex;flex-direction:column}
    .org-modal .modalbar{display:flex;align-items:center;justify-content:space-between;gap:12px;padding:12px 14px;border-bottom:1px solid rgba(255,255,255,.10);background:rgba(0,0,0,.20)}
    .org-modal .mtitle{font-weight:800;letter-spacing:.2px}
    .org-modal .msub{font-size:12px;color:var(--muted);margin-top:2px}
    .org-modal .mcontrols{display:flex;gap:8px;flex-wrap:wrap;align-items:center}
    .org-modal .mcontrols button{padding:9px 10px;border-radius:12px}
    .org-modal .modalbody{flex:1;position:relative;overflow:hidden;background:radial-gradient(900px 520px at 20% 20%, rgba(53,208,179,.10), transparent 60%),radial-gradient(900px 520px at 85% 30%, rgba(107,124,255,.12), transparent 60%)}
    #orgStage{position:absolute;left:50%;top:50%;transform:translate(-50%,-50%) scale(1);transform-origin:center;will-change:transform;cursor:grab;touch-action:none}
    #orgStage:active{cursor:grabbing}
    #orgStage svg{width:min(1200px,92vw);height:auto;display:block}

    @media (max-width:900px){.org-wrap{grid-template-columns:1fr}}
CSS

# Replace the organigrama CSS block entirely
$s =~ s/\n\s*\/\* Organigrama \*\/.*?\@media \(max-width:900px\)\{\.org-wrap\{grid-template-columns:1fr\}\}/\n$new/s;

# Also fix any broken stray media line if it exists
$s =~ s/\n\s*\(max-width:900px\)\{\.org-wrap\{grid-template-columns:1fr\}\}/\n    \@media (max-width:900px){.org-wrap{grid-template-columns:1fr}}/s;

open my $out,'>',$file or die $!;
print $out $s;
close $out;
