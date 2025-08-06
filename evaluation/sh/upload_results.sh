sas_backup="sp=racwdl&st=2025-08-06T06:04:37Z&se=2025-08-12T14:19:37Z&skoid=7b3a9ac3-4eaa-434a-8801-b2b90159bf0b&sktid=72f988bf-86f1-41af-91ab-2d7cd011db47&skt=2025-08-06T06:04:37Z&ske=2025-08-12T14:19:37Z&sks=b&skv=2024-11-04&spr=https&sv=2024-11-04&sr=c&sig=Lthjk3Em6oecZWIxPTt4jXahbZtdjVF1tFheSQur0b0%3D"
sas="${sas:-$sas_backup}"
azcopy copy --recursive outputs "https://sanbpx4p3idss6q.blob.core.windows.net/longcontext/models/siyuan/Qwen2.5-Math-Eval?${sas}"
azcopy copy --recursive logs "https://sanbpx4p3idss6q.blob.core.windows.net/longcontext/models/siyuan/Qwen2.5-Math-Eval-logs?${sas}"