# Create sample CSV file
# highlight and run these lines:
<#
"name,transaction,qty,amount,total" | Out-File c:\Scripts\data.csv
"ctgannon,buy,4,3.00,12.00"  | Out-File c:\Scripts\data.csv -Append
"gshields,sell,1200,1.00,1200.00" | Out-File c:\Scripts\data.csv -Append
"tevans,sell,8,9.00,72.00" | Out-File c:\Scripts\data.csv -Append
#>
<# Part 1 
Fixed script with proper formatting and logic
#>
$data = Import-Csv c:\Scripts\data.csv
$totalqty = 0
$totalsold = 0
$totalbought = 0

foreach ($line in $data) {
    if ($line.transaction -eq 'buy') {
        # buy transaction (we bought items)
        $totalqty += [int]$line.qty
        $totalbought += [decimal]$line.total
    } else {
        # sell transaction (we sold items)
        $totalqty -= [int]$line.qty
        $totalsold += [decimal]$line.total
    }
}

# Create summary CSV file
"totalqty,totalbought,totalsold,totalamt" | Out-File c:\Scripts\summary.csv
"$totalqty,$totalbought,$totalsold,$($totalsold-$totalbought)" | 
    Out-File c:\Scripts\summary.csv -Append

