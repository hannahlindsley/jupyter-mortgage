<%page args="interestrate, principal, term, overpayment, appreciation, monthlypayments, monthlypayments_no_over" />

<%!
from bloodloan.mortgage.mmath import MONTHS_IN_YEAR
from bloodloan.ui.ui import dollar, percent
%>

<h2>Mortgage amortization schedule</h2>

<p>Amortization schedule for a <span>${dollar(principal)}</span> loan over ${term} months at ${percent(interestrate)} interest.</p>

<p>Expect the property to appreciate ${percent(appreciation)} each year.</p>

%if overpayment != 0:
    <p>
        With a monthy overpayment of ${dollar(overpayment)},
        you can expect to pay off the loan in approximately ${int(len(monthlypayments) / MONTHS_IN_YEAR)} years
        (exactly ${len(monthlypayments)} months),
        or approximately ${int((len(monthlypayments_no_over) - len(monthlypayments)) / MONTHS_IN_YEAR)} years
        (exactly ${len(monthlypayments_no_over) - len(monthlypayments)} months)
        faster than the initial approximate ${int(len(monthlypayments_no_over) / MONTHS_IN_YEAR)} year
        (exact ${len(monthlypayments_no_over)} month) term.
    </p>
    <p>
        This means you will pay <span>${dollar(monthlypayments[-1].totalinterest)}</span> in interest over the term of the loan,
        saving <span>${dollar(monthlypayments_no_over[-1].totalinterest - monthlypayments[-1].totalinterest)}</span>
        of the full <span>${dollar(monthlypayments_no_over[-1].totalinterest)}</span>
        that would be paid over the entire term of the loan without an overpayment
    </p>
%else:
    <p>With a montly overpayment of ${dollar(0)}, you will pay off the loan in ${int(len(monthlypayments) / MONTHS_IN_YEAR)} years (${len(monthlypayments)} months). This will result in total interest payment of <span>${dollar(monthlypayments[-1].totalinterest)}</span></p>
%endif
