use aiken/math

pub fn check_pos_rational(num: Int, denom: Int) -> Bool {
  let max_component = 1_000_000_000_000_000_000
  expect num > 0
  expect denom > 0
  expect num <= max_component
  expect denom <= max_component
  True
}

pub fn reduce_fraction(num: Int, denom: Int) -> (Int, Int) {
  let g = math.gcd(num, denom)
  (num / g, denom / g)
}

pub fn eq_fraction(
  a_num: Int,
  a_denom: Int,
  b_num: Int,
  b_denom: Int,
) -> Bool {
  a_num * b_denom == a_denom * b_num
}

pub fn pow10(n: Int) -> Int {
  when n is {
    0 -> 1
    1 -> 10
    2 -> 100
    3 -> 1_000
    4 -> 10_000
    5 -> 100_000
    6 -> 1_000_000
    7 -> 10_000_000
    8 -> 100_000_000
    9 -> 1_000_000_000
    10 -> 10_000_000_000
    11 -> 100_000_000_000
    12 -> 1_000_000_000_000
    13 -> 10_000_000_000_000
    14 -> 100_000_000_000_000
    15 -> 1_000_000_000_000_000
    16 -> 10_000_000_000_000_000
    17 -> 100_000_000_000_000_000
    18 -> 1_000_000_000_000_000_000
    _ -> fail @"pow10: n out of bounds [0, 18]"
  }
}

// ═══════════════════════════════════════════════════════════
//  Tests
// ═══════════════════════════════════════════════════════════

// ── pow10 ──

test pow10_0() { pow10(0) == 1 }

test pow10_1() { pow10(1) == 10 }

test pow10_8() { pow10(8) == 100_000_000 }

test pow10_18() { pow10(18) == 1_000_000_000_000_000_000 }

test pow10_negative() fail {
  let x = pow10(-1)
  x == x
}

test pow10_too_large() fail {
  let x = pow10(19)
  x == x
}

// ── check_pos_rational ──

test check_pos_rational_ok() { check_pos_rational(500, 1000) }

test check_pos_rational_coprime() { check_pos_rational(7, 13) }

test check_pos_rational_at_max() {
  check_pos_rational(1_000_000_000_000_000_000, 1_000_000_000_000_000_000)
}

test check_pos_rational_zero_num() fail { check_pos_rational(0, 1000) }

test check_pos_rational_zero_denom() fail { check_pos_rational(500, 0) }

test check_pos_rational_neg_num() fail { check_pos_rational(-1, 1000) }

test check_pos_rational_neg_denom() fail { check_pos_rational(500, -1) }

test check_pos_rational_num_too_large() fail {
  check_pos_rational(1_000_000_000_000_000_001, 1)
}

test check_pos_rational_denom_too_large() fail {
  check_pos_rational(1, 1_000_000_000_000_000_001)
}

// ── reduce_fraction ──

test reduce_fraction_500_1000() { reduce_fraction(500, 1000) == (1, 2) }

test reduce_fraction_coprime() { reduce_fraction(7, 13) == (7, 13) }

test reduce_fraction_already_reduced() { reduce_fraction(3, 5) == (3, 5) }

test reduce_fraction_equal() { reduce_fraction(42, 42) == (1, 1) }

// ── eq_fraction ──

test eq_fraction_same() { eq_fraction(500, 1000, 1, 2) }

test eq_fraction_different_repr() { eq_fraction(2, 4, 3, 6) }

test eq_fraction_large() { eq_fraction(1_000_000, 2_000_000, 1, 2) }

test eq_fraction_different_value() { !eq_fraction(500, 1000, 1, 3) }

test eq_fraction_cross_different() { !eq_fraction(1, 2, 2, 3) }
