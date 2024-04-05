export function convertDate(iso: string | number | Date) {
    const d = new Date(iso);
    const convertDate = d.toLocaleDateString('pt-BR'); 
    return convertDate
}

export function generateNowISOTime(): string {
    const time = new Date();
    return time.toISOString();
}

export function convertDateInputToISODate(iso: string) {
    let isoDate = new Date(iso).toISOString();
  return isoDate;
}

export function convertISODateToInputValue(iso: String | Date){
    if(typeof(iso) !== "string"){
       return String(iso).split("T")[0]
    }
    return iso.split("T")[0]
}


