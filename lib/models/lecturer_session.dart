class LecturerSession {
  static String name = 'ผศ.กฤษณ์ ไชยวงศ์';
  static String email = 'krit.cha@pbru.ac.th';
  static String department = 'วิศวกรรมสารสนเทศและการสื่อสาร';

  static final List<Map<String, String>> allFaculty = [
    // Electrical Engineering
    {'name': 'ผศ.อนุรักษ์ เกษวัฒนากุล', 'dept': 'วิศวกรรมไฟฟ้า', 'email': 'anurak.kas@pbru.ac.th'},
    {'name': 'อ.บุรีรักษ์ สังข์คงเมือง', 'dept': 'วิศวกรรมไฟฟ้า', 'email': 'burirak.san@pbru.ac.th'},
    {'name': 'อ.กมลวรรณ วงศ์วุฒิ', 'dept': 'วิศวกรรมไฟฟ้า', 'email': 'kamonwan.won@pbru.ac.th'},
    {'name': 'ผศ.ดร.ราเชณ คณะนา', 'dept': 'วิศวกรรมไฟฟ้า', 'email': 'rachen.kan@pbru.ac.th'},
    {'name': 'ผศ.ดร.วิโรจน์ จงชนะชววัฒน์', 'dept': 'วิศวกรรมไฟฟ้า', 'email': 'wiroj.jon@pbru.ac.th'},
    
    // Energy Engineering
    {'name': 'อ.เจิมธง ปรารถนารักษ์', 'dept': 'วิศวกรรมพลังงาน', 'email': 'jermthong.par@pbru.ac.th'},
    {'name': 'ผศ.ดร.กังสดาล สกุลพงษ์มาลี', 'dept': 'วิศวกรรมพลังงาน', 'email': 'kangsadan.sak@pbru.ac.th'},
    {'name': 'อ.ดร.จุติพร อินทะนิน', 'dept': 'วิศวกรรมพลังงาน', 'email': 'jutiporn.int@pbru.ac.th'},
    {'name': 'อ.ชลีดล อินยาศรี', 'dept': 'วิศวกรรมพลังงาน', 'email': 'chaleedon.iny@pbru.ac.th'},
    {'name': 'อ.ปองพล รักการงาน', 'dept': 'วิศวกรรมพลังงาน', 'email': 'pongpol.rak@pbru.ac.th'},

    // Mechanical Engineering
    {'name': 'ผศ.ดร.ช่วงชัย ชุปวา', 'dept': 'วิศวกรรมเครื่องกล', 'email': 'chuangchai.chu@pbru.ac.th'},
    {'name': 'ผศ.ดร.อนุชา สายสร้อย', 'dept': 'วิศวกรรมเครื่องกล', 'email': 'anucha.sai@pbru.ac.th'},
    {'name': 'ผศ.ดร.ขวัญชัย หนาแน่น', 'dept': 'วิศวกรรมเครื่องกล', 'email': 'khwanchai.hna@pbru.ac.th'},
    {'name': 'ผศ.ดร.พิเชฐ นิลดวงดี', 'dept': 'วิศวกรรมเครื่องกล', 'email': 'phichet.nil@pbru.ac.th'},
    {'name': 'ผศ.ดร.ปรัชญา มุขดา', 'dept': 'วิศวกรรมเครื่องกล', 'email': 'prachya.muk@pbru.ac.th'},
    {'name': 'รศ.ดร.อุทัย ผ่องรัศมี', 'dept': 'วิศวกรรมเครื่องกล', 'email': 'uthai.pho@pbru.ac.th'},
    {'name': 'อ.ชยุต พลอยจิรภาส', 'dept': 'วิศวกรรมเครื่องกล', 'email': 'chayut.plo@pbru.ac.th'},
    {'name': 'อ.ดวงฤดี ชูตระกูล', 'dept': 'วิศวกรรมเครื่องกล', 'email': 'duangrudee.chu@pbru.ac.th'},

    // Industrial Engineering
    {'name': 'อ.ประเสริฐ ปราชญ์ประยูร', 'dept': 'วิศวกรรมอุตสาหการ', 'email': 'prasert.pra@pbru.ac.th'},
    {'name': 'อ.อลงกรณ์ ฉัตรเมืองปัก', 'dept': 'วิศวกรรมอุตสาหการ', 'email': 'alongkorn.cha@pbru.ac.th'},
    {'name': 'อ.ชลาลัย วงเวียน', 'dept': 'วิศวกรรมอุตสาหการ', 'email': 'chalalai.won@pbru.ac.th'},

    // Interior Architecture
    {'name': 'ผศ.วิเชียร เข็มเงิน', 'dept': 'สาขาสถาปัตยกรรมภายใน', 'email': 'wichian.khe@pbru.ac.th'},
    {'name': 'อ.เฉลิมศักดิ์ แก้วเกาะ', 'dept': 'สาขาสถาปัตยกรรมภายใน', 'email': 'chalermsak.kae@pbru.ac.th'},
    {'name': 'อ.จิตราพร ชัยเสริมวงศ์', 'dept': 'สาขาสถาปัตยกรรมภายใน', 'email': 'jitraporn.cha@pbru.ac.th'},
    {'name': 'อ.จิตรา มีทองคำ', 'dept': 'สาขาสถาปัตยกรรมภายใน', 'email': 'jitra.mee@pbru.ac.th'},
    {'name': 'อ.ภัทรวรรณ เอมกมล', 'dept': 'สาขาสถาปัตยกรรมภายใน', 'email': 'phattarawan.aim@pbru.ac.th'},
    {'name': 'อ.จตุพล อังศุเวช', 'dept': 'สาขาสถาปัตยกรรมภายใน', 'email': 'jatuphon.ang@pbru.ac.th'},

    // Information & Communication Engineering
    {'name': 'ผศ.กฤษณ์ ไชยวงศ์', 'dept': 'วิศวกรรมสารสนเทศและการสื่อสาร', 'email': 'krit.cha@pbru.ac.th'},
    {'name': 'ผศ.ดร.ปาณิศา แก้วสวัสดิ์', 'dept': 'วิศวกรรมสารสนเทศและการสื่อสาร', 'email': 'panisa.kae@pbru.ac.th'},
    {'name': 'อ.ดร.กิตติพงศ์ นวลใย', 'dept': 'วิศวกรรมสารสนเทศและการสื่อสาร', 'email': 'kittipong.nua@pbru.ac.th'},
    {'name': 'อ.ดร.ดวงกมล อังอำนวยศิริ', 'dept': 'วิศวกรรมสารสนเทศและการสื่อสาร', 'email': 'duangkamol.ang@pbru.ac.th'},
    {'name': 'อ.ดร.ประกิจ อินทะชัย', 'dept': 'วิศวกรรมสารสนเทศและการสื่อสาร', 'email': 'prakij.int@pbru.ac.th'},
  ];
}
