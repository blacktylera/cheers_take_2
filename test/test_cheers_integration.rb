require_relative 'helper'

class TestCheersIntegration < Minitest::Test

  def test_zero_arguments_prints_help_message
    output = `./cheers`
    expected = <<EOS
I'd cheer for you, if only I knew who you were :(
Try again with `./cheers.rb [Name] [MM/DD Birthday]
EOS
    assert_equal expected, output
  end

  def test_one_valid_argument
    output = `./cheers Abby`
    expected = <<EOS
Give me an... A
Give me a... B
Give me a... B
Give me a... Y
Abby's just GRAND!

I would wish you a Happy Birthday, if I knew when that was!
EOS
    assert_equal expected, output
  end

  def test_all_an_letters
    output = `./cheers AEFHILMNORSX`
    expected = <<EOS
Give me an... A
Give me an... E
Give me an... F
Give me an... H
Give me an... I
Give me an... L
Give me an... M
Give me an... N
Give me an... O
Give me an... R
Give me an... S
Give me an... X
AEFHILMNORSX's just GRAND!

I would wish you a Happy Birthday, if I knew when that was!
EOS
    assert_equal expected, output
  end

  def test_one_valid_argument_with_hyphenated_name
    output = `./cheers Mary-Jane`
    expected = <<EOS
Give me an... M
Give me an... A
Give me an... R
Give me a... Y
Give me a... J
Give me an... A
Give me an... N
Give me an... E
Mary-Jane's just GRAND!

I would wish you a Happy Birthday, if I knew when that was!
EOS
    assert_equal expected, output
  end

  def test_one_valid_argument_with_double_name
    output = `./cheers "Mary Jane"`
    expected = <<EOS
Give me an... M
Give me an... A
Give me an... R
Give me a... Y
Give me a... J
Give me an... A
Give me an... N
Give me an... E
Mary Jane's just GRAND!

I would wish you a Happy Birthday, if I knew when that was!
EOS
    assert_equal expected, output
  end

  def test_birthday_instead_of_name
    output = `./cheers 08/25`
    expected = <<EOS
I'd cheer for you, if only I knew who you were :(
Try again with `./cheers.rb [Name] [MM/DD Birthday]
EOS
    assert_equal expected, output
  end

  def test_only_non_word_characters_in_name
    output = `./cheers *!?`
    expected = <<EOS
I'd cheer for you, if only I knew who you were :(
Try again with `./cheers.rb [Name] [MM/DD Birthday]
EOS
    assert_equal expected, output
  end

  def test_no_characters_in_name
    output = `./cheers ""`
    expected = <<EOS
I'd cheer for you, if only I knew who you were :(
Try again with `./cheers.rb [Name] [MM/DD Birthday]
EOS
    assert_equal expected, output
  end

  def test_only_whitespace_in_name
    output = `./cheers "  "`
    expected = <<EOS
I'd cheer for you, if only I knew who you were :(
Try again with `./cheers.rb [Name] [MM/DD Birthday]
EOS
    assert_equal expected, output
  end

  def test_invalid_month_date
    output = `./cheers "Mary Jane" 25/08`
    expected = <<EOS
Give me an... M
Give me an... A
Give me an... R
Give me a... Y
Give me a... J
Give me an... A
Give me an... N
Give me an... E
Mary Jane's just GRAND!

I would wish you a Happy Birthday, if I knew when that was!
EOS
    assert_equal expected, output
  end

  def test_invalid_day_date
    output = `./cheers "Mary Jane" 12/42`
    expected = <<EOS
Give me an... M
Give me an... A
Give me an... R
Give me a... Y
Give me a... J
Give me an... A
Give me an... N
Give me an... E
Mary Jane's just GRAND!

I would wish you a Happy Birthday, if I knew when that was!
EOS
    assert_equal expected, output
  end

  def test_invalid_date_in_future
    output = `./cheers "Mary Jane" 08/25/2015`
    expected = <<EOS
Give me an... M
Give me an... A
Give me an... R
Give me a... Y
Give me a... J
Give me an... A
Give me an... N
Give me an... E
Mary Jane's just GRAND!

I would wish you a Happy Birthday, if I knew when that was!
EOS
    assert_equal expected, output
  end

  def test_date_with_zero_month
    output = `./cheers Abby 08/25`
    expected = <<EOS
Give me an... A
Give me a... B
Give me a... B
Give me a... Y
Abby's just GRAND!

Awesome!  Your birthday is in 127 days! Happy Birthday in advance!
EOS
    assert_equal expected, output
  end
end