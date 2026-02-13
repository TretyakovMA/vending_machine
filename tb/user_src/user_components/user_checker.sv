`ifndef USER_CHECKER
`define USER_CHECKER
class user_checker extends uvm_component;
    `uvm_component_utils(user_checker)

    local vm_reg_block	     reg_block_h;  //информация о товарах хранится в регистрах vend_item

    function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

    function void connect_phase(uvm_phase phase);
		super.connect_phase(phase); //Получение указателя на reg_block_h
		if(!uvm_config_db #(vm_reg_block)::get(this, "", "reg_block", reg_block_h))
			`uvm_fatal(get_type_name(), "Failed to get reg_block")
	endfunction: connect_phase



    //Вспомогательные функции для расчета ожидаемой транзакции
	local function shortreal convert_to_rub(bit [5:0] coin, currency_type_t currency);
		bit [1:0] exchange_rate;
		shortreal res;

		//exchange_rate берется из регистра vend_cfg
		exchange_rate = reg_block_h.vend_cfg.exchange_rate.get_mirrored_value();

		//перевод в рубли
		case (currency)
			RUB: res = shortreal'(coin);
			USD: res = shortreal'(coin) * exchange_rate;
			EUR: res = shortreal'(coin) * exchange_rate * 1.5;
		endcase

		return res;
	endfunction: convert_to_rub

	local function shortreal get_item_price(bit[4:0] item_num, bit [8:0] client_id);
		int           discount;
		shortreal     price;
		bit           vip;
		bit [7:0]     item_discount;

		//price и item_discount берутся из регистров vend_item
		price         = reg_block_h.vend_item[item_num].item_price.get_mirrored_value();
		item_discount = reg_block_h.vend_item[item_num].item_discount.get_mirrored_value();
        `uvm_info(get_type_name(), $sformatf("Base price: %0f, item discount: %0f", price, item_discount), UVM_FULL)
		//Расчет скидки
		discount = (client_id % 3) * 10;
		vip      = (client_id % 10 == 0);

		if (vip)           discount += 10;
		if (discount > 30) discount  = 30;

		//Расчет итоговой цены с учетом скидок
		price   -= item_discount;
		price   *= (100 - discount) / 100.0;

		return price;
	endfunction: get_item_price

	local function shortreal calculate_balance(bit [5:0] q[$], currency_type_t cur_q[$]);
		shortreal balance = 0;
		
		foreach(q[i]) begin
			balance += convert_to_rub(q[i], cur_q[i]);
		end
		
		return balance;
	endfunction: calculate_balance



	//Функция расчета ожидаемой транзакции
	function user_transaction calculate_exp_transaction(
        user_transaction tr, 
        int client_points = 0
    );
		shortreal             balance;
		shortreal             item_price;
		user_transaction      calc_tr;

		calc_tr               = tr.clone_me();
		
		//Расчет баланса и цены товара
		item_price            = get_item_price(calc_tr.item_num, calc_tr.client_id);
		balance               = calculate_balance(calc_tr.coin_in_q, calc_tr.currency_type_q);

        `uvm_info(get_type_name(), $sformatf("Calculated balance: %0f, item price: %0f", balance, item_price), UVM_FULL)

		//Заполнение полей ожидаемой транзакции
		calc_tr.item_out      = (1 << calc_tr.item_num);
		calc_tr.change_out    = $ceil(balance - item_price); //Формат округления пока не определен в спецификации
		calc_tr.no_change     = ($ceil(balance - item_price) == 0) ? 1 : 0;
		calc_tr.client_points = client_points + $floor(item_price / 20);

		return calc_tr;
	endfunction: calculate_exp_transaction

endclass: user_checker
`endif