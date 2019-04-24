RSpec.describe Reredos do
  it "has a version number" do
    expect(Reredos::VERSION).not_to be nil
  end

  describe '#valid_email?' do
    describe 'length' do
      context 'valid total, username, and domain-label length' do
        let(:email){ 'user'*16 + '@' + ('a'*63+'.')*2 + 'a'*63 }
        it 'accept what has 256 chars' do
          expect(Reredos.valid_email?(email)).to be_truthy
        end
      end
      context 'invalid total length' do
        let(:email){ 'user@' + ('a'*63+'.')*3 + 'a'*60 }
        it 'reject what has over 256 chars' do
          expect(Reredos.valid_email?(email)).to be_falsy
        end
      end
      context 'invalid username length' do
        let(:email){ 'user'*16 + 'a@example.com' }
        it 'reject what has over 64 chars username' do
          expect(Reredos.valid_email?(email)).to be_falsy
        end
      end
      context 'invalid domain-label length' do
        let(:email){ 'user@' + 'a'*64 + '.com' }
        it 'reject what has over 63 chars domain-label' do
          expect(Reredos.valid_email?(email)).to be_falsy
        end
      end
    end

    describe 'available characters' do
      context 'valid symbols in username' do
        let(:email){ 'user.User-USER_0000+1111@example.com' }
        it 'accept .-_+' do
          expect(Reredos.valid_email?(email)).to be_truthy
        end
      end
      context 'invalid symbol in username' do
        let(:email){ 'user.User-USER_0000+1111~2222@example.com' }
        it 'reject ~' do
          expect(Reredos.valid_email?(email)).to be_falsy
        end
      end
      context 'valid symbols in domain name' do
        let(:email){ 'user@example-example.example.com' }
        it 'accept -' do
          expect(Reredos.valid_email?(email)).to be_truthy
        end
      end
      context 'invalid symbols in domain name' do
        let(:email){ 'user@example+example.example.com' }
        it 'reject +' do
          expect(Reredos.valid_email?(email)).to be_falsy
        end
      end
    end

    describe 'structure' do
      describe 'the number of @' do
        context 'only one' do
          let(:email){ 'user@example.com' }
          it 'accept what has one @' do
            expect(Reredos.valid_email?(email)).to be_truthy
          end
        end
        context 'no @' do
          let(:email){ 'userexample.com' }
          it 'accept what has no @' do
            expect(Reredos.valid_email?(email)).to be_falsy
          end
        end
        context 'two @s' do
          let(:email){ 'user@user@example.com' }
          it 'accept what has two @s' do
            expect(Reredos.valid_email?(email)).to be_falsy
          end
        end
      end
      context 'consecutive dots in domain' do 
        let(:email){ 'user@example..example.com' }
        it 'reject ruthlessly, if used in past' do
          expect(Reredos.valid_email?(email)).to be_falsy
        end
      end
    end
    describe 'TLD' do
      context 'ended by -, which does not exist as TLD' do 
        let(:email){ 'user@example.com-' }
        it 'reject' do
          expect(Reredos.valid_email?(email)).to be_falsy
        end
      end
    end
  end
end
