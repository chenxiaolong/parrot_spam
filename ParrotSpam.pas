program ParrotSpam;

uses
    classes,
    sysutils;

function spam(remaining: Integer; parrots: TStringList): AnsiString;
var
    builder: TStringBuilder;
    i: Integer;
label
    out;
begin
    builder := TStringBuilder.create(remaining);

    while true do
    begin
        for i := 0 to parrots.count - 1 do
        begin
            if remaining < length(parrots[i]) then
                goto out;
            builder.append(parrots[i]);
            remaining -= length(parrots[i]);
        end;
    end;

    out:
    spam := builder.toString;
end;

var
    parrots: TStringList;
    i: Integer;
begin
    parrots := TStringList.create;

    for i := 1 to paramCount() do
        if length(paramStr(i)) > 0 then
            parrots.add(paramStr(i));

    if parrots.count = 0 then
    begin
        writeLn('Nothing to repeat');
        halt(1);
    end;

    writeLn(spam(4000, parrots));
end.
